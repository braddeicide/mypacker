import os
import fnmatch
import argparse
import subprocess
import threading
import signal
import time

class Threadedrun(threading.Thread):
    def __init__(self, _command, _stdoutval, _args):
        threading.Thread.__init__(self)
        self.command   = command
        self.stdoutval = stdoutval
        self.args      = args

    def run(self):

        if not self.args.silent:
            print "Running: ",self.command.split(),self.stdoutval

        p = subprocess.Popen(self.command.split(), stdout=self.stdoutval)
        # this blocks, means you can read output however it is slow over many builds
        while p.poll() is None:
            if not self.args.silent and not self.args.logtofile:
                print p.stdout.readline().rstrip()

def which(file):
    combpath = os.environ["PATH"] + ':' + args.path
    for path in combpath.split(":"):
        if os.path.exists(path + os.path.sep + file):
                return path + os.path.sep + file
    print "Failed, could not find " +file+ " in path "+combpath
    return None

def signalHandler(signum, flag):
    print 'Signal handler called with signal', signum
    for t in threads:
        t.join()
    exit(signum)

options, parallel, stdoutval = "", "", "";
             
parser   = argparse.ArgumentParser()
parser.add_argument('-t', '--type',      help='virtualbox, vmware, all'    , default='virtualbox')
parser.add_argument('-p', '--parallel',  help='1 .. n'                     , default=1)
parser.add_argument('-P', '--path',      help='Directory to append to path', default='')
parser.add_argument('-s', '--silent',    help='1 .. n'                     , action="store_true")
parser.add_argument('-l', '--logtofile', help='will create machine.log'    , action="store_true")
parser.add_argument('-m', '--matching',  help='build machines matching'    , default='*')

args     = parser.parse_args() 
parallel = int(args.parallel)

# Locate exe without using shell=True
packer    = which("packer")
vagrant   = which("vagrant")

# So we can interupt builds
if os.name == 'posix':
  signal.signal(signal.SIGINT, signalHandler)
if os.name == 'nt':
  signal.signal(signal.CTRL_C_EVENT, signalHandler)

# directories with template.json
dirs  = [root for root,dir,file in os.walk(".") if fnmatch.filter(file,"template.json") and fnmatch.fnmatch(root,'*'+args.matching+'*')]

print 'Building ', dirs

# construct arguments
if args.type   == 'virtualbox':
    options = '--only virtualbox-iso '
elif args.type == 'vmware':
    options = '--only vmware-iso '

threads = []
# run packer
for machine in dirs:
    if args.logtofile:
        stdoutval = open(machine+'.log', 'w') 
    else:
        stdoutval = subprocess.PIPE

    command = packer +' build '+options+machine+os.path.sep+"template.json"

    try:
      while (len(threading.enumerate()) >= parallel+1):
        time.sleep(1)
      threadedrun = Threadedrun(command, stdoutval,args)
      threads.append(threadedrun)
      threadedrun.start()
    except (KeyboardInterrupt, SystemExit):
      print '\n! Received keyboard interrupt, quitting threads.\n'
      exit()

# vagrant import
# Ensure builds are all finished
for t in threads:
    t.join()
boxes = [name for name in os.listdir('output')]
for machine in boxes:
    command = vagrant+' box add -f '+machine+' output'+os.path.sep+machine
    # Don't need threads here, but lets use what we aleady have for stdout/logging etc.
    threadedrun = Threadedrun(command, stdoutval,args)
    threads.append(threadedrun)
    threadedrun.start()
    threadedrun.join()

# Stop main thread exiting before all threads finish, only main thread catches signals and ctrl+c is nice.
for t in threads:
    t.join()

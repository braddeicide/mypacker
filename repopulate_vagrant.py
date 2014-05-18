import os
import fnmatch
import argparse
import subprocess
import threading
import signal

class Threadedrun(threading.Thread):
    def __init__(self, command, stdoutval, args):
        threading.Thread.__init__(self)
        self.command = command
        self.stdoutval = stdoutval
        self.args = args

    def run(self):
        semaphore.acquire()

        if not self.args.silent:
                print "Running: ",self.command.split(),self.stdoutval

        p = subprocess.Popen(self.command.split(), stdout=self.stdoutval)
        # this blocks, means you can read output however it is slow over many builds
        while p.poll() is None:
            if not self.args.silent and not self.args.logtofile:
                print p.stdout.readline().rstrip()
        semaphore.release()

def which(file):
    for path in os.environ["PATH"].split(":"):
        if os.path.exists(path + "/" + file):
                return path + "/" + file

    return None

options, parallel, stdoutval = "", "", "";
             
parser = argparse.ArgumentParser()
parser.add_argument('-t', '--type', help='virtualbox, vmware, all', default='virtualbox')
parser.add_argument('-p', '--parallel', help='1 .. n', default=1)
parser.add_argument('-s', '--silent', help='1 .. n', action="store_true")
parser.add_argument('-l', '--logtofile', help='will create machine.log', action="store_true")
args = parser.parse_args() 
parallel = int(args.parallel)

# Locate exe without using shell=True
packer = which("packer")
vagrant = which("vagrant")

# Used to ensure we're only executing "parallel" builds concurrently.
global semaphore
semaphore = threading.BoundedSemaphore(parallel)

# directories with template.json
dirs = [root for root,dir,file in os.walk(".") if fnmatch.filter(file,"template.json")]

# construct arguments
if args.type == 'virtualbox':
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

    command = packer +' build '+options+machine+"/template.json"
    threadedrun = Threadedrun(command, stdoutval,args)
    threads.append(threadedrun)
    threadedrun.start()

# vagrant import
boxes = [name for name in os.listdir('output/')]
for machine in boxes:
    command = vagrant+' box add -f '+machine+' output/ '+machine
    threadedrun = Threadedrun(command, stdoutval,args)
    threads.append(threadedrun)
    threadedrun.start()

# Stop main thread exiting before all threads finish, only main thread catches signals and ctrl+c is nice.
for t in threads:
    t.join()

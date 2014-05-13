import os
import fnmatch
import argparse
import subprocess
import threading


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
        
options, parallel, stdoutval = "", "", "";
             
parser = argparse.ArgumentParser()
parser.add_argument('-t', '--type', help='virtualbox, vmware, all', default='virtualbox')
parser.add_argument('-p', '--parallel', help='1 .. n', default=1)
parser.add_argument('-s', '--silent', help='1 .. n', action="store_true")
parser.add_argument('-l', '--logtofile', help='will create machine.log', action="store_true")
args = parser.parse_args() 
parallel = int(args.parallel)

# Used to ensure we're only executing "parallel" builds concurrently.
semaphore = threading.BoundedSemaphore(parallel)

# directories with template.json
dirs = [root for root,dir,file in os.walk(".") if fnmatch.filter(file,"template.json")]

# construct arguments
if args.type == 'virtualbox':
    options = '--only virtualbox-iso '
elif args.type == 'vmware':
    options = '--only vmware-iso '

# run packer
for machine in dirs:
    logfile = open(machine+'.log', 'w')
    if args.logtofile:
        stdoutval = logfile
    else:
        stdoutval = subprocess.PIPE

    command = '/usr/local/bin/packer build '+options+machine+"/template.json"
    threadedrun = Threadedrun(command, stdoutval,args)
    threadedrun.start()

# vagrant import
boxes = [name for name in os.listdir('output/')]
for machine in boxes:
    command = '/usr/bin/vagrant','box','add','-f',machine,"output/"+machine
    threadedrun = Threadedrun(command, stdoutval,args)
    threadedrun.start()

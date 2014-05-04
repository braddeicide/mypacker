#!/usr/bin/python

import os
import argparse
import subprocess
from subprocess import call
options  = "";

parser = argparse.ArgumentParser()
parser.add_argument('-t', '--type', help='virtualbox, vmware, all')
parser.add_argument('-p', '--parallel', help='1 .. n')
parser.add_argument('-s', '--silent', help='1 .. n')
args = parser.parse_args()

#def parallelism():
#    if processes < args.parallel:
#        return -1

# directories with template.json
dirs = [root for root,dir,file in os.walk(".") if fnmatch.filter(file,"template.json")]

# construct arguments
if args.type == 'virtualbox':
    options = '--only virtualbox-iso '
elif args.type == 'vmware':
    options = '--only vmware-iso '

# run packer
for machine in dirs:
    command = '/home/brad/bin/packer build '+options+machine+"/template.json"
    p = subprocess.Popen(command.split(), stdout=subprocess.PIPE)
    while p.poll() is None:
        if not args.silent:
            print p.stdout.readline().rstrip()

# vagrant import
boxes = [name for name in os.listdir('output/')]
for machine in boxes:
    p = subprocess.Popen(['/usr/bin/vagrant','box','add','-f',machine,"output/"+machine], stdout=subprocess.PIPE)
    while p.poll() is None:
        if not args.silent:
            print p.stdout.readline().rstrip()


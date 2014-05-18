mypacker
========

my stash of Packer files for my own and works use, built from multiple sourses including veewee scripts.  Thanks veewee for all the hard work packer users benefit from ;)

Packer can be called directory from the head directory. eg.
  packer build freebsd-10.0-amd64/freebsd-10.0-amd64.json

Or use the included python script which allows controlled parallel builds

usage: repopulate_vagrant.py [-h] [-t TYPE] [-p PARALLEL] [-s] [-l]

'-t', '--type',      help='virtualbox, vmware, all', default='virtualbox'

'-p', '--parallel',  help='1 .. n'

'-s', '--silent',    help='1 .. n'

'-l', '--logtofile', help='will create machine.log'

*Caveats*
A failed packer build leaves temporary files and packer won't run again until they're cleaned.  I'm not keen on deleting them for you.


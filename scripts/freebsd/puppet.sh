#!/bin/sh -x

freebsd_major=`uname -r | awk -F. '{ print $1 }'`

#Install sudo, curl and ca_root_nss
if [ $freebsd_major -gt 9 ]; then
  # Use pkgng
  pkg install -y puppet
else
  # Use old pkg
  pkg_add -r puppet 
fi

exit

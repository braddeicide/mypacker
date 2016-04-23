#!/bin/sh -x

freebsd_major=`uname -r | awk -F. '{ print $1 }'`

#Install sudo, curl and ca_root_nss
if [ $freebsd_major -gt 9 ]; then
  # Use pkgng
  pkg install -y puppet
  # puppet37||puppet38||puppet4
  pkg install -y puppet4
else
  # Use old pkg
  pkg_add -r puppet 
fi

gem install hiera-eyaml

exit

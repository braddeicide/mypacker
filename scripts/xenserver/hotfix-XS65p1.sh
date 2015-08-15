#!/bin/sh -x

CACHE=/tmp/xen/

# Citrix suggest an installation order that's quite detatched from release numbers, often doesn't matter but sometimes it does.
# I'd like to parse http://updates.xensource.com/XenServer/updates.xml however it doesn't contain order info, and xml in bash? ug.
PATCHES=(
http://downloadns.citrix.com.edgesuite.net/10340/XS65ESP1.zip
http://downloadns.citrix.com.edgesuite.net/10566/XS65ESP1002.zip
http://downloadns.citrix.com.edgesuite.net/10597/XS65ESP1003.zip
http://downloadns.citrix.com.edgesuite.net/10663/XS65ESP1004.zip
http://downloadns.citrix.com.edgesuite.net/10662/XS65E010.zip
http://support.citrix.com/filedownload/CTX201514/XS65ESP1005.zip
)

# Set xen provided envs
. /etc/xensource-inventory

mkdir -p $CACHE
for PATCHZ in "${PATCHES[@]}"; do
  #PATCH=$(basename -s .zip $PATCHZ)
  PATCH=$(basename $PATCHZ .zip)
  cd $CACHE

  if [ ! -f $CACHE/$PATCH.zip  ]; then
    wget -c --directory-prefix=$CACHE $PATCHZ
  fi

  unzip $CACHE/$PATCH.zip $PATCH.xsupdate

  PATCHUUID=$(xe patch-upload file-name=$CACHE/$PATCH.xsupdate);
  xe patch-apply uuid=${PATCHUUID} host-uuid=${INSTALLATION_UUID};
  xe patch-clean uuid=${PATCHUUID};

done

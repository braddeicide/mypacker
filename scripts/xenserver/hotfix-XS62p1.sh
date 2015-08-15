#!/bin/sh -x

CACHE=/tmp/xen

# Citrix suggest an installation order that's quite detatched from release numbers, often doesn't matter but sometimes it does.
# I'd like to parse http://updates.xensource.com/XenServer/updates.xml however it doesn't contain order info, and xml in bash? ug.

PATCHES=(
http://downloadns.citrix.com.edgesuite.net/8707/XS62ESP1.zip
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

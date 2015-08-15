#!/bin/sh -x

CACHE=/tmp/xen

# Citrix suggest an installation order that's quite detatched from release numbers, often doesn't matter but sometimes it does.
# I'd like to parse http://updates.xensource.com/XenServer/updates.xml however it doesn't contain order info, and xml in bash? ug.

PATCHES=(
http://downloadns.citrix.com.edgesuite.net/9708/XS62ESP1014.zip
http://downloadns.citrix.com.edgesuite.net/10134/XS62ESP1012.zip
http://downloadns.citrix.com.edgesuite.net/10206/XS62ESP1019.zip
http://downloadns.citrix.com.edgesuite.net/9617/XS62ESP1009.zip
http://downloadns.citrix.com.edgesuite.net/10193/XS62ESP1017.zip
http://downloadns.citrix.com.edgesuite.net/10325/XS62ESP1021.zip
http://downloadns.citrix.com.edgesuite.net/10309/XS62ESP1020.zip
http://downloadns.citrix.com.edgesuite.net/10567/XS62ESP1024.zip
http://downloadns.citrix.com.edgesuite.net/10564/XS62ESP1025.zip
http://downloadns.citrix.com.edgesuite.net/10596/XS62ESP1026.zip
http://downloadns.citrix.com.edgesuite.net/10661/XS62ESP1027.zip
http://downloadns.citrix.com.edgesuite.net/10654/XS62ESP1028.zip
)

# Set xen provided envs
. /etc/xensource-inventory

mkdir -p $CACHE
for PATCHZ in "${PATCHES[@]}"; do
  #PATCH=$(basename -s .zip $PATCHZ)
  PATCH=$(basename $PATCHZ .zip)
  cd $CACHE

  if [ ! -f $CACHE/$PATCH.zip  ]; then
    --directory-prefix=$CACHE $PATCHZ
  fi

  unzip $CACHE/$PATCH.zip $PATCH.xsupdate

  PATCHUUID=$(xe patch-upload file-name=$CACHE/$PATCH.xsupdate);
  xe patch-apply uuid=${PATCHUUID} host-uuid=${INSTALLATION_UUID};
  xe patch-clean uuid=${PATCHUUID};

done

#!/bin/sh -x

CACHE=/tmp/xen

# Citrix suggest an installation order that's quite detatched from release numbers, often doesn't matter but sometimes it does.
# I'd like to parse http://updates.xensource.com/XenServer/updates.xml however it doesn't contain order info, and xml in bash? ug.

PATCHES=(
http://support.citrix.com/servlet/KbServlet/download/33250-102-714009/XS61E009.zip
http://downloadns.citrix.com.edgesuite.net/9489/XS61E040.zip
http://downloadns.citrix.com.edgesuite.net/9278/XS61E038.zip
http://downloadns.citrix.com.edgesuite.net/8155/XS61E030.zip
http://downloadns.citrix.com.edgesuite.net/9274/XS61E039.zip
http://downloadns.citrix.com.edgesuite.net/10133/XS61E046.zip
http://downloadns.citrix.com.edgesuite.net/9706/XS61E044.zip
http://downloadns.citrix.com.edgesuite.net/10192/XS61E048.zip
http://downloadns.citrix.com.edgesuite.net/10205/XS61E050.zip
http://downloadns.citrix.com.edgesuite.net/10324/XS61E051.zip
http://downloadns.citrix.com.edgesuite.net/10660/XS61E054.zip
http://downloadns.citrix.com.edgesuite.net/10681/XS61E056.zip
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
  rm -f $CACHE/$PATCH.zip

  PATCHUUID=$(xe patch-upload file-name=$CACHE/$PATCH.xsupdate);
  rm -f $CACHE/$PATCH.xsupdate
  xe patch-apply uuid=${PATCHUUID} host-uuid=${INSTALLATION_UUID};
  xe patch-clean uuid=${PATCHUUID};

done

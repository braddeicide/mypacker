set -ue

# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/veewee/.vbox_version)

# http://www.unixmen.com/fix-building-opengl-support-module-failed-error-virtualbox/
#cd /usr/src/kernels/`uname -r`/include/drm
#ln -s /usr/include/drm/drm.h drm.h  
#ln -s /usr/include/drm/drm_sarea.h drm_sarea.h  
#ln -s /usr/include/drm/drm_mode.h drm_mode.h  
#ln -s /usr/include/drm/drm_fourcc.h drm_fourcc.h

# Minimal tools required
yum -y install bzip2

cd /tmp
mount -o loop /home/veewee/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
# Oracle has never heard of this CentOS things and every version is buggy 
# Note, not sure why 7.1 is failing
if egrep --quiet "6.5|6.6|6.7|7.1" /etc/redhat-release
then
  set +e
fi
sh /mnt/VBoxLinuxAdditions.run

umount /mnt
rm -rf /home/veewee/VBoxGuestAdditions_*.iso


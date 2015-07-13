# Installing the virtualbox guest additions
VBOX_VERSION=$(cat /home/veewee/.vbox_version)

# Minimal tools required
yum -y install bzip2

cd /tmp
mount -o loop /home/veewee/VBoxGuestAdditions_$VBOX_VERSION.iso /mnt
sh /mnt/VBoxLinuxAdditions.run
umount /mnt
rm -rf /home/veewee/VBoxGuestAdditions_*.iso


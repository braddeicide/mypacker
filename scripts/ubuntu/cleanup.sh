apt-get -y autoremove
apt-get -y clean

echo "cleaning up gest additions"
rm -rf VBoxGuestAdditions_*.iso VBoxGuestAdditions_*.iso.?

echo "cleaning up dhcp leases"
rm /var/lib/dhcp/*

echo "cleaning up udev rules"
if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
  rm /etc/udev/rules.d/70-persistent-net.rules
fi
mkdir /etc/udev/rules.d/70-persistent-net.rules
rm -rf /dev/.udev/
if [ -f /lib/udev/rules.d/75-persistent-net-generator.rules ]; then
  rm /lib/udev/rules.d/75-persistent-net-generator.rules
fi

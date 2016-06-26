date > /etc/vagrant_box_build_time

mkdir /home/vagrant/.ssh
# --quiet added to fix seg fault bug
wget --no-check-certificate --quiet\
    'https://github.com/mitchellh/vagrant/raw/master/keys/vagrant.pub' \
    -O /home/vagrant/.ssh/authorized_keys
chown -R vagrant /home/vagrant/.ssh
chmod -R go-rwsx /home/vagrant/.ssh

# set pkg path for users
echo " "
echo " Setting PKG_PATH for users "
echo " "
echo " export PKG_PATH=http://mirror.internode.on.net/pub/OpenBSD/`uname -r`/packages/`arch -s`/ " >> /root/.profile
echo " export PKG_PATH=http://mirror.internode.on.net/pub/OpenBSD/`uname -r`/packages/`arch -s`/ ">> /home/vagrant/.profile

# install wget/curl/bash/vim and its dependencies
echo " "
echo " Installing needed packages "
echo " "
export PKG_PATH=http://mirror.internode.on.net/pub/OpenBSD/`uname -r`/packages/`arch -s`/
pkg_add -I wget curl bash vim--no_x11 rsync--iconv bzip2 ngrep

# giving root & vagrant bash as shell
echo " "
echo " Giving root/vagrant bash as a shell "
echo " "
usermod -s /usr/local/bin/bash vagrant
usermod -s /usr/local/bin/bash root

# sudo
# Defaults requiretty is not present in the sudoers file
# env_keep I'll leave it as it is since user's path is same or more comprehensive than root's path
echo " "
echo " Setting sudo to work with vagrant "
echo " "
echo "# Uncomment to allow people in group wheel to run all commands without a password" >> /etc/sudoers
echo "%wheel        ALL=(ALL) NOPASSWD: SETENV: ALL" >> /etc/sudoers

/etc/rc.d/sendmail stop

# install the ports system for who wants to use it
echo " "
echo " Installing the ports system ! "
echo " "
cd /tmp
wget http://mirror.internode.on.net/pub/OpenBSD/`uname -r`/ports.tar.gz
cd /usr
sudo tar xzf /tmp/ports.tar.gz

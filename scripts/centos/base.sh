# Base install
set -ue

# Set mirror if's defined
#if [ ! -z "$MIRROR" ]; then
if [ ! -z ${MIRROR+x} ]; then
  export QUOTEDMIRROR=$(echo $MIRROR | sed 's/\//\\\//g')
  sed -i 's/#baseurl=http:\/\/mirror.centos.org\//baseurl='$QUOTEDMIRROR'/' /etc/yum.repos.d/CentOS-Base.repo 
  sed -i 's/mirrorlist/#mirrorlist/' /etc/yum.repos.d/CentOS-Base.repo
fi

sed -i "s/^[a-z\s]*requiretty/#Defaults requiretty/" /etc/sudoers

cat > /etc/yum.repos.d/epel.repo << EOM
[epel]
name=epel
baseurl=http://mirror.internode.on.net/pub/epel/\$releasever/\$basearch
enabled=1
gpgcheck=0
EOM

# Make ssh faster by not waiting on DNS
echo "UseDNS no" >> /etc/ssh/sshd_config

#yum -y install gcc make gcc-c++ kernel-devel-`uname -r` zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils
# Centos drops old kernel-devel so we must be running latest kernel when we compile virtualbox drivers.
yum -y install gcc make gcc-c++ kernel kernel-devel zlib-devel openssl-devel readline-devel sqlite-devel perl wget dkms nfs-utils
reboot
sleep 60

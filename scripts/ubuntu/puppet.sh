wget https://apt.puppetlabs.com/puppetlabs-release-trusty.deb
dpkg -i puppetlabs-release-trusty.deb
rm -f puppetlabs-release-trusty.deb
apt-get update
apt-get -y install puppet puppetmaster

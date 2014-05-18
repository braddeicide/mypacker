wget https://apt.puppetlabs.com/puppetlabs-release-`lsb_release -cs`.deb
dpkg -i puppetlabs-release-`lsb_release -cs`.deb
rm -f puppetlabs-release-`lsb_release -cs`.deb
apt-get update
apt-get -y install puppet puppetmaster rubygems
gem install hiera-eyaml

echo << EOF >> /etc/apt/preferences.d/00-puppet.pref
Package: puppet puppet-common puppetmaster-passenger
Pin: version 3*
Pin-Priority: 501
EOF

wget https://apt.puppetlabs.com/puppetlabs-release-`lsb_release -cs`.deb
dpkg -i puppetlabs-release-`lsb_release -cs`.deb
rm -f puppetlabs-release-`lsb_release -cs`.deb
apt-get update
apt-get -y install puppet puppetmaster ruby 
gem install hiera-eyaml

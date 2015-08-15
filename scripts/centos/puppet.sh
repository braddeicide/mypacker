# Install Puppet
set -ue

cat > /etc/yum.repos.d/puppetlabs.repo << EOM
[puppetlabs-dependencies]
name=puppetlabdsdependencies
baseurl=http://yum.puppetlabs.com/el/\$releasever/dependencies/\$basearch
enabled=1
gpgcheck=0

[puppetlabs]
name=puppetlabs
baseurl=http://yum.puppetlabs.com/el/\$releasever/products/\$basearch
enabled=1
gpgcheck=0
EOM

yum -y install puppet facter ruby-shadow
gem install hiera-eyaml

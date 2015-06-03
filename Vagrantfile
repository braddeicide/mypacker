# -*- mode: ruby -*-
# vi: set ft=ruby :

# Simple vagrant file when i want to boot one of these babies.
# inspired by https://github.com/patrickdlee/vagrant-examples/blob/master/example6/Vagrantfile

nodes = [
  { :host => 'centos65',   :box => 'centos-6.5-amd64-virtualbox.box'  },
  { :host => 'centos66',   :box => 'centos-6.6-amd64-virtualbox.box'  },
  { :host => 'centos70',   :box => 'centos-7-amd64-virtualbox.box'    },
  { :host => 'ubuntu1204', :box => 'ubuntu-12-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1404', :box => 'ubuntu-14-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1410', :box => 'ubuntu-14-10-x64-virtualbox.box'  }
]

# BSD doesn't get working shared folders, virtualbox and vmware
unlovednodes = [
  { :host => 'freebsd10',  :box => 'freebsd-10.0-amd64-virtualbox.box', :ip => "10.0.1.2"},
  { :host => 'openbsd54',  :box => 'openbsd-5.4-amd64-virtualbox.box',  :ip => "10.0.1.3"},
  { :host => 'openbsd55',  :box => 'openbsd-5.5-amd64-virtualbox.box',  :ip => "10.0.1.4"},
  { :host => 'openbsd56',  :box => 'openbsd-5.6-amd64-virtualbox.box',  :ip => "10.0.1.5"},
  { :host => 'openbsd57',  :box => 'openbsd-5.7-amd64-virtualbox.box',  :ip => "10.0.1.6"},
]

Vagrant.configure(2) do |config|
  nodes.each do |node|
    config.ssh.insert_key = false
    config.vm.define node[:host] do |node_conf|
      node_conf.vm.box=node[:box]
    end
  end

  unlovednodes.each do |node|
    config.ssh.insert_key = false
    config.vm.network "private_network", ip: "10.0.1.10"
    config.vm.synced_folder ".", "/vagrant", :nfs => true, id: "vagrant-root"
    config.vm.define node[:host] do |node_conf|
      node_conf.vm.box=node[:box]
      node_conf.vm.network "private_network", ip: node[:ip]
    end
  end
end

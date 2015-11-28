# -*- mode: ruby -*-
# vi: set ft=ruby :

# Simple vagrant file when i want to boot one of these babies.
# inspired by https://github.com/patrickdlee/vagrant-examples/blob/master/example6/Vagrantfile

nodes = [
  { :host => 'centos65',   :box => 'centos-6.5-amd64-virtualbox.box'  },
  { :host => 'centos66',   :box => 'centos-6.6-amd64-virtualbox.box'  },
  { :host => 'centos67',   :box => 'centos-6.7-amd64-virtualbox.box'  },
  { :host => 'centos71',   :box => 'centos-7.1-amd64-virtualbox.box'  },
  { :host => 'ubuntu1204', :box => 'ubuntu-12-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1404', :box => 'ubuntu-14-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1510', :box => 'ubuntu-15-10-x64-virtualbox.box'  },
]

# BSD doesn't get working shared folders, virtualbox and vmware
nfsnodes = [
  { :host => 'freebsd100',  :box => 'freebsd-10.0-amd64-virtualbox.box', :ip => "10.0.1.2"},
  { :host => 'freebsd102',  :box => 'freebsd-10.2-amd64-virtualbox.box', :ip => "10.0.1.3"},
  { :host => 'openbsd56',   :box => 'openbsd-5.6-amd64-virtualbox.box',  :ip => "10.0.1.4"},
  { :host => 'openbsd57',   :box => 'openbsd-5.7-amd64-virtualbox.box',  :ip => "10.0.1.5"},
  { :host => 'xenserver61', :box => 'XenServer61-virtualbox.box',        :ip => "10.0.1.6"},
  { :host => 'xenserver62', :box => 'XenServer62-virtualbox.box',        :ip => "10.0.1.7"},
  { :host => 'xenserver65', :box => 'XenServer65-virtualbox.box',        :ip => "10.0.1.8"},
]

Vagrant.configure(2) do |config|

  nodes.each do |node|
    config.ssh.insert_key = false
    config.vm.define node[:host] do |node_conf|
      node_conf.vm.box=node[:box]
    end
  end

  nfsnodes.each do |nfsnode|
    config.ssh.insert_key = false
    config.ssh.shell = "sh"
    config.vm.define nfsnode[:host] do |node_conf|
      node_conf.vm.synced_folder ".", "/vagrant", :nfs => true, id: "vagrant-root"
      node_conf.vm.box=nfsnode[:box]
      node_conf.vm.network "private_network", ip: nfsnode[:ip]
    end
  end
end

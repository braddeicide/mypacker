# -*- mode: ruby -*-
# vi: set ft=ruby :

# Simple vagrant file when i want to boot one of these babies.
# inspired by https://github.com/patrickdlee/vagrant-examples/blob/master/example6/Vagrantfile

nodes = [
  { :host => 'centos68',   :box => 'centos-6.8-amd64-virtualbox.box'  },
  { :host => 'centos72',   :box => 'centos-7.2-amd64-virtualbox.box'  },
  { :host => 'ubuntu1204', :box => 'ubuntu-12-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1404', :box => 'ubuntu-14-04-x64-virtualbox.box'  },
  { :host => 'ubuntu1604', :box => 'ubuntu-16-04-x64-virtualbox.box'  },
]

# BSD doesn't get working shared folders, virtualbox and vmware
nfsnodes = [
  { :host => 'freebsd103',  :box => 'freebsd-10.3-amd64-virtualbox.box', :ip => "10.0.1.3"},
  { :host => 'openbsd57',   :box => 'openbsd-5.7-amd64-virtualbox.box',  :ip => "10.0.1.4"},
  { :host => 'openbsd58',   :box => 'openbsd-5.8-amd64-virtualbox.box',  :ip => "10.0.1.5"},
  { :host => 'openbsd59',   :box => 'openbsd-5.9-amd64-virtualbox.box',  :ip => "10.0.1.9"},
  { :host => 'openbsd59_32',:box => 'openbsd-5.9-i386-virtualbox.box',   :ip => "10.0.1.10"},
  { :host => 'xenserver61', :box => 'XenServer61-virtualbox.box',        :ip => "10.0.1.6"},
  { :host => 'xenserver62', :box => 'XenServer62-virtualbox.box',        :ip => "10.0.1.7"},
  { :host => 'xenserver65', :box => 'XenServer65-virtualbox.box',        :ip => "10.0.1.8"},
  { :host => 'xenserver70', :box => 'XenServer70-virtualbox.box',        :ip => "10.0.1.11"},
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

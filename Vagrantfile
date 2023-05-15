# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "bento/centos-7"
    ansible.vm.hostname = "ansible-server"
    ansible.vm.network "private_network", ip: '192.168.33.10'

    ansible.vm.provider "virtualbox" do |v|
      v.name = "Ansible-Server"
      v.memory = 1024
     # v.linked_clone = true
    end
    ansible.vm.provision "shell", path: "./provision/install_ansible.sh"

    ansible.vm.provision "shell", privileged: false, inline: <<-SHELL
      ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
    SHELL
    ansible.vm.synced_folder '.', '/vagrant', disabled: false

  end

  config.vm.define "lb01" do |lb01|
    lb01.vm.box = "bento/ubuntu-22.04"
    lb01.vm.hostname = "lb01"
    lb01.vm.network "private_network", ip: '192.168.33.15'

    lb01.vm.provider "virtualbox" do |v|
      v.name = "Ansible-lb01"
      v.memory = 512
     # v.linked_clone = true
    end
    lb01.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "web01" do |web01|
    web01.vm.box = "bento/ubuntu-22.04"
    web01.vm.hostname = "web01"
    web01.vm.network "private_network", ip: '192.168.33.20'

    web01.vm.provider "virtualbox" do |v|
      v.name = "Ansible-web01"
      v.memory = 512
      # v.linked_clone = true
    end
    web01.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "web023" do |web023|
    web023.vm.box = "bento/ubuntu-22.04"
    web023.vm.hostname = "web023"
    web023.vm.network "private_network", ip: '192.168.33.30'

    web023.vm.provider "virtualbox" do |v|
      v.name = "Ansible-web023"
      v.memory = 512
      # v.linked_clone = true
    end
    web023.vm.synced_folder '.', '/vagrant', disabled: true
  end

end

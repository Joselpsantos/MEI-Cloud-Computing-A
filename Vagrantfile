# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.vm.define "ansible" do |ansible|
    ansible.vm.box = "generic/centos9s"
    ansible.vm.hostname = "ansible-srv"
    ansible.vm.network "private_network", ip: '192.168.33.50'

    ansible.vm.provider "virtualbox" do |v|
      v.name = "Ansible-srv"
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
    lb01.vm.box = "generic/ubuntu2204"
    lb01.vm.hostname = "lb01"
    lb01.vm.network "private_network", ip: '192.168.33.51'

    lb01.vm.provider "virtualbox" do |v|
      v.name = "Ansible-lb01"
      v.memory = 1024
     # v.linked_clone = true
    end
    lb01.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "web01" do |web01|
    web01.vm.box = "generic/ubuntu2204"
    web01.vm.hostname = "web01"
    web01.vm.network "private_network", ip: '192.168.33.52'

    web01.vm.provider "virtualbox" do |v|
      v.name = "Ansible-web01"
      v.memory = 1024
      # v.linked_clone = true
    end
    web01.vm.provision "shell", path: "provision.sh"
    web01.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo bash -c 'echo "This is web01" > /var/www/html/index.html'
    SHELL
    web01.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "web02" do |web02|
    web02.vm.box = "generic/ubuntu2204"
    web02.vm.hostname = "web02"
    web02.vm.network "private_network", ip: '192.168.33.53'

    web02.vm.provider "virtualbox" do |v|
      v.name = "Ansible-web02"
      v.memory = 1024
      # v.linked_clone = true
    end
    web02.vm.provision "shell", path: "provision.sh"
    web02.vm.provision "shell", privileged: false, inline: <<-SHELL
    sudo bash -c 'echo "This is web02" > /var/www/html/index.html'
    SHELL
    web02.vm.synced_folder '.', '/vagrant', disabled: true
  end

  config.vm.define "master" do |master|
    master.vm.box = "generic/ubuntu2204"
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.33.10"
    master.vm.provider "virtualbox" do |vb|
      vb.name = "postgresql-master"
      vb.memory = "1024"
    end
    master.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y postgresql postgresql-contrib
      # Configure master PostgreSQL settings here
    SHELL
  end

  config.vm.define "replica" do |replica|
    replica.vm.box = "generic/ubuntu2204"
    replica.vm.hostname = "replica"
    replica.vm.network "private_network", ip: "192.168.33.20"
    replica.vm.provider "virtualbox" do |vb|
      vb.name = "postgresql-replica"
      vb.memory = "1024"
    end
    replica.vm.provision "shell", inline: <<-SHELL
      sudo apt-get update
      sudo apt-get install -y postgresql postgresql-contrib
      # Configure replica PostgreSQL settings here
    SHELL
  end

  config.vm.define "consul" do |consul|
    consul.vm.box = "generic/ubuntu2204"
    consul.vm.hostname = "consul"
    consul.vm.network "private_network", ip: '192.168.33.54'

    consul.vm.provider "virtualbox" do |v|
      v.name = "Ansible-consul"
      v.memory = 1024
      # v.linked_clone = true
    end
    consul.vm.synced_folder '.', '/vagrant', disabled: true
  end

end
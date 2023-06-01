Vagrant.configure("2") do |config|
    # Configuração do servidor ansible
    config.vm.define "ansible" do |ansible|
      ansible.vm.box = "generic/centos9s"
      ansible.vm.hostname = "web1"
      ansible.vm.network "private_network", ip: "192.168.50.5"
      ansible.vm.provider "virtualbox" do |vb|
        vb.memory = "768"
      end
      ansible.vm.provision "shell", path: "./provision/install_ansible.sh"
      ansible.vm.provision "shell", privileged: false, inline: <<-SHELL
        ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
      SHELL
      ansible.vm.synced_folder '.', '/vagrant', disabled: false
    end

    # Configuração do load Balancer
    config.vm.define "lb01" do |lb01|
      lb01.vm.box = "generic/ubuntu220"
      lb01.vm.hostname = "lb01"
      lb01.vm.network "private_network", ip: "192.168.50.6"
      lb01.vm.provider "virtualbox" do |vb|
        vb.memory = "768"
      end
    end

    config.vm.define "lb02" do |lb02|
      lb02.vm.box = "generic/ubuntu220"
      lb02.vm.hostname = "lb02"
      lb02.vm.network "private_network", ip: "192.168.50.7"
      lb02.vm.provider "virtualbox" do |vb|
        vb.memory = "768"
      end
    end

    # Configuração do servidor web
    config.vm.define "web1" do |web1|
      web1.vm.box = "ubuntu/bionic64"
      web1.vm.hostname = "web1"
      web1.vm.network "private_network", ip: "192.168.50.10"
      web1.vm.provider "virtualbox" do |vb|
        vb.memory = "768"
      end
    end
  
    config.vm.define "web2" do |web2|
      web2.vm.box = "ubuntu/bionic64"
      web2.vm.hostname = "web2"
      web2.vm.network "private_network", ip: "192.168.50.11"
      web2.vm.provider "virtualbox" do |vb|
        vb.memory = "768"
      end
    end
  
    # Configuração do MongoDB
    config.vm.define "mongo1" do |mongo1|
      mongo1.vm.box = "ubuntu/bionic64"
      mongo1.vm.hostname = "mongo1"
      mongo1.vm.network "private_network", ip: "192.168.50.20"
      mongo1.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  
    config.vm.define "mongo2" do |mongo2|
      mongo2.vm.box = "ubuntu/bionic64"
      mongo2.vm.hostname = "mongo2"
      mongo2.vm.network "private_network", ip: "192.168.50.21"
      mongo2.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  
    config.vm.define "mongo3" do |mongo3|
      mongo3.vm.box = "ubuntu/bionic64"
      mongo3.vm.hostname = "mongo3"
      mongo3.vm.network "private_network", ip: "192.168.50.22"
      mongo3.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  
    # Configuração do PgBouncer
    config.vm.define "pgbouncer" do |pgbouncer|
      pgbouncer.vm.box = "ubuntu/bionic64"
      pgbouncer.vm.hostname = "pgbouncer"
      pgbouncer.vm.network "private_network", ip: "192.168.50.30"
      pgbouncer.vm.provider "virtualbox" do |vb|
        vb.memory = "1024"
      end
    end
  
    # Configuração do PostgreSQL
    config.vm.define "pg1" do |pg1|
      pg1.vm.box = "ubuntu/bionic64"
      pg1.vm.hostname = "pg1"
      pg1.vm.network "private_network", ip: "192.168.50.40"
      pg1.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  
    config.vm.define "pg2" do |pg2|
      pg2.vm.box = "ubuntu/bionic64"
      pg2.vm.hostname = "pg2"
      pg2.vm.network "private_network", ip: "192.168.50.41"
      pg2.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  
    config.vm.define "pg3" do |pg3|
      pg3.vm.box = "ubuntu/bionic64"
      pg3.vm.hostname = "pg3"
      pg3.vm.network "private_network", ip: "192.168.50.42"
      pg3.vm.provider "virtualbox" do |vb|
        vb.memory = "512"
      end
    end
  end
  
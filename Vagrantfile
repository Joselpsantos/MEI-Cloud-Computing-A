Vagrant.configure("2") do |config|

    config.vm.define "ansible" do |ansible|
        ansible.vm.box = "generic/centos7"
        ansible.vm.hostname = "ansible-srv"
        ansible.vm.network "private_network", ip: '192.168.44.20'
    
        ansible.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
            v.name = "Ansible-VM"
            v.memory = 760
            # v.linked_clone = true
        end
        ansible.vm.provision "shell", privileged: true, path: "./provision/install_ansible.sh"

        ansible.vm.provision "shell", privileged: false, inline: <<-SHELL
          ssh-keygen -t rsa -N "" -f ~/.ssh/id_rsa
        SHELL

        ansible.vm.synced_folder '.', '/vagrant', disabled: false

      end
    
    config.vm.define "lb01" do |lb01|
        lb01.vm.box = "bento/ubuntu-22.04"
        lb01.vm.hostname = "lb01"
        lb01.vm.network "private_network", ip: '192.168.44.25'
    
        lb01.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
            v.name = "lb01"
            v.memory = 760

            # v.linked_clone = true
        end
        
        lb01.vm.synced_folder '.', '/vagrant', disabled: true
      end

    config.vm.define "webapp1" do |node|
        node.vm.box = "bento/ubuntu-22.04"
        node.vm.hostname = "webapp1"
        node.vm.network :private_network, ip: "192.168.44.10"
        node.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
            v.name = "WebNode1"
            v.memory = 760
            v.cpus = 2
            v.linked_clone = true
      end
      node.vm.provision "shell", privileged: true, path: "./provision/web.sh"

    end

    config.vm.define "webapp2" do |node|
        node.vm.box = "bento/ubuntu-22.04"
        node.vm.hostname = "webapp2"
        node.vm.network :private_network, ip: "192.168.44.11"
        node.vm.provider "virtualbox" do |v|
            v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
            v.name = "WebNode2"
            v.memory = 760
            v.cpus = 2
            v.linked_clone = true
        end
        node.vm.provision "shell", privileged: true, path: "./provision/web.sh"

      end

    config.vm.define "sockets" do |node|
      node.vm.box = "bento/ubuntu-22.04"
      node.vm.hostname = "sockets"
      node.vm.network :private_network, ip: "192.168.44.15"
      node.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
        v.name = "SocketsNode"
        v.memory = 760
        v.cpus = 2
        v.linked_clone = true
      end
      node.vm.provision "shell", path: "./provision/install_sockets_dependencies.sh"

    end

    config.vm.define "database1" do |node|
      node.vm.box = "bento/ubuntu-22.04"
      node.vm.hostname = "database1"
      node.vm.network :private_network, ip: "192.168.44.30"
      node.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
        v.name = "DatabaseNode1"
        v.memory = 760
        v.cpus = 2
        v.linked_clone = true
      end
      
      node.vm.synced_folder './provision', '/vagrant', disabled: false
      node.vm.provision "shell", path: "./provision/install_database_dependencies_master.sh"

    end

    config.vm.define "database2" do |node|
      node.vm.box = "bento/ubuntu-22.04"
      node.vm.hostname = "database2"
      node.vm.network :private_network, ip: "192.168.44.31"
      node.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
        v.name = "DatabaseNode2"
        v.memory = 760
        v.cpus = 2
        v.linked_clone = true
      end
      
      node.vm.synced_folder './provision', '/vagrant', disabled: false
      node.vm.provision "shell", path: "./provision/install_database_dependencies_slave.sh"

    end

    config.vm.define "pgbouncer" do |node|
      node.vm.box = "bento/ubuntu-22.04"
      node.vm.hostname = "pgbouncer"
      node.vm.network :private_network, ip: "192.168.44.40"
      node.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
        v.name = "PgBouncer"
        v.memory = 760
        v.cpus = 2
        v.linked_clone = true
      end
      
      node.vm.synced_folder './provision', '/vagrant', disabled: false
      #node.vm.provision "shell", path: "./provision/install_database_dependencies_slave.sh"

    end

    config.vm.define "consul" do |node|
      node.vm.box = "bento/ubuntu-22.04"
      node.vm.hostname = "consul"
      node.vm.network :private_network, ip: "192.168.44.70"
      node.vm.provider "virtualbox" do |v|
        v.customize ["modifyvm", :id, "--groups", "/ProjectA"]
        v.name = "consul-server"
        v.memory = 760
        v.cpus = 2
        v.linked_clone = true
      end

      node.vm.synced_folder '.', '/vagrant', disabled: false

    end

end
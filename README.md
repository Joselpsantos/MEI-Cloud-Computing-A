
Title
===
Abstract:xxx
## Papar Information
- Title:  `Cloud computing project part A`
- Authors:  José Santos and Rui Paiva
- Preprint: [https://arxiv.org/abs/xx]()
- Full-preprint: [paper position]()
- 

![image](https://github.com/Joselpsantos/MEI-Cloud-Computing-A/assets/113514374/a52521fd-1983-45f2-8336-48a5e6dea447)

#### Connections ubtitle:
* Green - Sockets
* Red - Load Balancer
* Black - Database

## Install & Dependence
- Virtual Box
- Vagrant

## How to use

- To get the machines up and runnning
  ```
  vagrant up
  ```
- After the machines are running connect to ansible vm
  ```
  vagrant ssh ansible
  ```
- In the vm terminal go to shared folder
  ```
  cd ../../vagrant
  ```
- Execute the following playbooks in this order
  ```
  ansible-playbook -i hosts 00_ssh_key_scan.yamll -v
  
  ansible-playbook -i hosts 01_add_ssh_key.yml --ask-pass

  #This will install consul in all the nodes and setup the files needed fo service discovery
  #Will also define the services to show in consul ui
  ansible-playbook -i hosts 02_install_consul.yml -v

  #Install nginx in the lload balancer, setup consul templates with nginx 
  ansible-playbook -i hosts 03_install_nginx.yml -v
  ```

- To activate the websockets server:
  ```
  vagrant ssh sockets
  cd /vagrant/ws
  php websockets_server.php
  ```
  After steps it is possible to check the consul ui via http://192.168.44.70:8500/ui and get access to the web pages via http://http://192.168.44.25/
## Node Specs
### Load Balancer

The load balancer is configured with nginx and consul templates to detect new or downed web nodes.

### Web Server

The web server only runs php code and serves the site.

### Web Sockets 

The web sockets service was divided into a node of its own.

### Database 

The database was separated from the web node. There are two database nodes, one is the master server and the other is the replica. In this moment the pgbouncer is not running. When it is it will be possible automatticly serve the web nodes with high availability.


  


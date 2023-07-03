
Title
===
Abstract:xxx
## Papar Information
- Title:  `Cloud computing project part A`
- Authors:  José Santos and Rui Paiva
- Preprint: [https://arxiv.org/abs/xx]()
- Full-preprint: [paper position]()
- 

![image](https://github.com/Joselpsantos/MEI-Cloud-Computing-A/assets/113514374/b8283821-a076-43fe-9a90-762926d6109e)


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
- Exchange ssh keys
  ```
  ansible-playbook -i hosts 00_ssh_key_scan.yamll -v
  ansible-playbook -i hosts 01_add_ssh_key.yml --ask-pass
  ```
  
  # Install consul in all the nodes and setup the files needed fo service discovery
  ```
  ansible-playbook -i hosts 02_install_consul.yml -v
  ```
  
  # Install nginx in the lload balancer, setup consul templates with nginx
  ```
  ansible-playbook -i hosts 03_install_nginx.yml -v
  ```

  # To activate the websockets server:
  ```
  vagrant ssh sockets
  cd /vagrant/ws
  php websockets_server.php
  ```
  Web pages: http://http://192.168.44.25/
  Consul UI: http://192.168.44.70:8500/ui      

## Node Specs
### Load Balancer

Ubuntu - Nginx with consul template

### Web Server

Ubuntu - The web server only runs php code and serves the site.

### Web Sockets 

Ubuntu - The web sockets service was divided into a node of its own.

### Database 

Ubuntu - Posgresql 

### Service discovery
Ubuntu - Consul

### Provision 
Centos7 - Ansible

  


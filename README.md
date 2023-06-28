Title
===
Abstract:xxx
## Papar Information
- Title:  `paper name`
- Authors:  José Santos and Rui Paiva
- Preprint: [https://arxiv.org/abs/xx]()
- Full-preprint: [paper position]()
- 
![image](https://github.com/Joselpsantos/MEI-System/assets/113514374/238c6258-b835-4e38-83d4-d57d59b6ad11)

## Install & Dependence
- Virtual Box
- Vagrant
- Ansible

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
  After steps it is possible to check the consul ui via http://192.168.44.70:8500/ui and get access to the web pages via http://http://192.168.44.25/

## Directory Hierarchy
```
```
## Code Details
### Tested Platform
- software
  ```
  OS: Debian unstable (May 2021), Ubuntu LTS
  Python: 3.8.5 (anaconda)
  PyTorch: 1.7.1, 1.8.1
  ```
- hardware
  ```
  CPU: Intel Xeon 6226R
  GPU: Nvidia RTX3090 (24GB)
  ```
### Hyper parameters
```
```
## References
- [paper-1]()
- [paper-2]()
- [code-1](https://github.com)
- [code-2](https://github.com)
  


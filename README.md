Title
===
Two Web Servers, ansible and load balancer.
## Goals
Tasks – Replicate TP class examples
1. Create a 3 node Vagrant setup (lb01, web01, web02) using Ubuntu 22.04
1. Install nginx on the 3 nodes
2. Setup the two web servers to serve a simple HTML page (“Hello, web01”, “Hello, web02”)
3. Setup the remaining node (lb01) to serve as a load balancer to web01 and web02
4. Test that the basic setup is working
5. Test all the balance methods
1. Q: What is the purpose of each one? (Pros / cons)
2. Q: What would happen with JSON Web Tokens? What about traditional sessions and cookies?
6. Check the access logs across nodes, what is the problem?
1. Customize logs and headers to make it more useful
7. Set a weight of 3 to node web01 and verify the result
8. Configure static assets such as jpg images to always be served by web02
9. What happens to requests if one web node is down?
1. What happens when it gets back up?
<br><b>Challenge: automate provisioning with Ansible and create playbooks + templates to test each step</b>

• Tasks – Additional challenge
1. Setup a load balancer in front of your small app (2 nodes of simple php
script querying a table in a 3rd node with the DB )
1. Create two endpoints (or php files): 1) cpu intensive task; 2) db intensive task
2. Use vegeta to assess performance when using one versus two php nodes
## Install & Dependence
- VirtualBox
- (Space in disk)
- Browser


## Use
- Setup:
  ```
  vagrant up
  ```
- Enter SSH:
  ```
  vagrant ssh ansible
  cd /vagrant/ansible
  ```
- Keyscan:
  <br>Add the fingerprints of our target hosts to the ~/.ssh/known_hosts of our control node:
  ```
  ansible-playbook -i hosts 00_ssh_key_scan.yml -v
  ```
- Copy SSH key:
  ```
  ansible-playbook -i hosts 01_add_ssh_key.yml --ask-pass
  ```
- Install NGINX in LB01:
  ```
  ansible-playbook -i hosts 02_installnginx.yml
  ```
- See in action:<br>
Open in browser this address.<br>
  [http://192.168.33.51]()
  


## Directory Hierarchy
```
|—— .vagrant
|    |—— machines
|        |—— ansible
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|        |—— lb01
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— vagrant_cwd
|        |—— web01
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|        |—— web02
|            |—— virtualbox
|                |—— action_provision
|                |—— action_set_name
|                |—— box_meta
|                |—— creator_uid
|                |—— id
|                |—— index_uuid
|                |—— private_key
|                |—— synced_folders
|                |—— vagrant_cwd
|    |—— rgloader
|        |—— loader.rb
|—— 00_ssh_key_scan.yml
|—— 01_add_ssh_key.yml
|—— 02_installnginx.yml
|—— hosts
|—— provision
|    |—— install_ansible.sh
|—— provision.sh
|—— roles
|    |—— NGINX
|        |—— tasks
|            |—— main.yml
|        |—— templates
|            |—— index.html.j2
|        |—— vars
|            |—— main.yml
|—— Vagrantfile
```
## Code Details
### Load Balancer
- Change config NGINX
  ```
  cd /etc/nginx
  sudo nano nginx.conf
  ```

- See logs
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
## Issues
- Error: Failed to provision box: Vagrant was unable to mount VirtualBox shared folders. This is usually
because the filesystem "vboxsf" is not available
  ```
  vagrant plugin install vagrant-vbguest
  vagrant <node> reload
  ```
## References

- [NGINX](https://docs.nginx.com/)
  

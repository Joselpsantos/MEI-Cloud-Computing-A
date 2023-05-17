Title
===
Abstract:xxx
## Papar Information
- Title:  `paper name`
- Authors:  `A`,`B`,`C`
- Preprint: [https://arxiv.org/abs/xx]()
- Full-preprint: [paper position]()
- Video: [video position]()

## Install & Dependence
- python
- pytorch
- numpy


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
  ansible-playbook -i hosts example_0/ssh_key_scan.yml -v
  ```
- Copy SSH key:
  ```
  ansible-playbook -i hosts example_1/add_ssh_key.yml --ask-pass
  ```
- Install NGINX:
  ```
  ansible-playbook -i hosts example_02_installnginx.yml
  ```


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
  
## License

## Citing
If you use xxx,please use the following BibTeX entry.
```
```

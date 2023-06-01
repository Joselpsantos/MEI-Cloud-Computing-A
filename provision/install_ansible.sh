#!/bin/bash

# Atualizar os pacotes
echo "Update the OS"
yum update -y
yum install vim -y

# Instalar o Ansible
echo "Install Ansible"
yum install epel-release -y
yum install ansible -y

# Instalar o Netcat, para port scanning, etc
echo "Install Netcat"
yum install nc

# Instalar o Nano, para edição de ficheiros
echo "Install Nano"
sudo yum install -y nano
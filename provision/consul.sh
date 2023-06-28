sudo apt-get update

sudo apt-get install consul -y

#consul tls cert create -server -dc dc1 -domain consul

cd ../..

#sudo mkdir - var/lib/consul

sudo mkdir --parents /etc/consul.d

sudo chown -R consul:consul /var/lib/consul
sudo chown -R 775 /var/lib/consul
sudo chown -R consul:consul /etc/consul.d

sudo touch /etc/systemd/system/consul.service
sudo cp /vagrant/provision/consul-templates/consul-service/consul.service /etc/systemd/system/consul.service

sudo systemctl daemon-reload

#Criar o ficheiro de configuração
sudo touch /etc/consul.d/config.json
sudo cp /vagrant/provision/consul-templates/consul-service/config.json /etc/consul.d/
sudo chown -R consul:consul /var/lib/consul
#para ver logs journalctl -u consul -f
sudo systemctl start consul

sudo systemctl enable consul

#verificar que o serviço está a funcionar
systemctl is-active --quiet consul

apt-get install nginx -y

rm -rf /etc/nginx/sites-enabled/default

#cp /vagrant/provision/consul-templates/consul-service/Consul/files/consul.conf /etc/nginx/sites-available/

#ln -s /etc/nginx/sites-available/consul.conf /etc/nginx/sites-enabled/

#sudo nginx -t



#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
# sudo tee -a /etc/apt/sources.list.d/hashicorp.list

#sudo apt-get install consul

#Generate the gossip encryption key

#consul keygen

#consul tls ca create

#Generate TLS certificates for RPC encryption
#consul tls cert create -server -dc dc1 -domain consul

#Configure Consul Server

#sudo touch /etc/consul.d/server.hcl

#sudo chown --recursive consul:consul /etc/consul.d

#sudo chmod 640 /etc/consul.d/server.hcl

#sudo systemctl enable consul

#sudo systemctl start consul

#sudo apt install nginx


#consul acl bootstrap
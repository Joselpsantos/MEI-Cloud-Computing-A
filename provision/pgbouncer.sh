#Create the apt repository configuration file for adding the PGDG apt server
sudo sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'

#Import the repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -                   

#Update the apt package manager to ensure it uses the added repository
sudo apt update

#Install the PgBouncer application using apt
sudo apt install pgbouncer -y

systemctl reload pgbouncer.service
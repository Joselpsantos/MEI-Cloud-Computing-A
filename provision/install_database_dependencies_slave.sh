echo -e "$MSG_COLOR$(hostname): Update package lists\033[0m"
sudo apt-get update

echo -e "$MSG_COLOR$(hostname): Install PHP-FPM and necessary modules\033[0m"
sudo apt-get install -y php php-fpm php-common php-cli php-mysql php-pgsql php-pdo php-mbstring php-zip zip unzip

echo -e "$MSG_COLOR$(hostname): Install PostgreSQL and its PHP extension\033[0m"
sudo apt-get install -y postgresql postgresql-contrib php-pgsql

echo -e "$MSG_COLOR$(hostname):  Create database\033[0m"
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
sudo -u postgres psql -c "CREATE USER write WITH PASSWORD 'write';"
sudo -u postgres psql -c "CREATE USER read WITH PASSWORD 'read';"
sudo -u postgres psql -c "CREATE DATABASE mydatabase;"
sudo -u postgres psql -c "CREATE DATABASE mydatabase OWNER myuser;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO write;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO read;"
sudo -u postgres psql -c "\c mydatabase"
#Criar a tabela

echo -e "$MSG_COLOR$(hostname):  Create tables\033[0m"
# PGPASSWORD=mypassword sudo -u postgres psql -U myuser -h localhost -d mydatabase -f /vagrant/provision/dump.sql # change to ./provision/dump.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump_sessions_table.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump_files_table.sql

cp ../../vagrant/postgres_slave/pg_hba.conf /etc/postgresql/14/main/
cp ../../vagrant/postgres_slave/postgresql.conf /etc/postgresql/14/main/

sudo service postgresql restart

sudo -u postgres psql -d mydatabase -c  "CREATE SUBSCRIPTION messagesub CONNECTION 'dbname=mydatabase host=192.168.44.30 user=replica password=mypassword port=5432' PUBLICATION messagepub;"
sudo -u postgres psql -d mydatabase -c  "CREATE SUBSCRIPTION datasub CONNECTION 'dbname=mydatabase host=192.168.44.30 user=replica password=mypassword port=5432' PUBLICATION datapub;"
sudo -u postgres psql -d mydatabase -c  "CREATE SUBSCRIPTION imagesub CONNECTION 'dbname=mydatabase host=192.168.44.30 user=replica password=mypassword port=5432' PUBLICATION imagepub;"

echo -e "$MSG_COLOR$(hostname): View users and databases in PostgreSQL\033[0m"
sudo -u postgres psql -c "\dRs+"
sudo -u postgres psql -c "\list"
sudo -u postgres psql -d mydatabase -c "\dt"

sudo -u postgres psql -d mydatabase -c "Select * from messages;"
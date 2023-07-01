echo -e "$MSG_COLOR$(hostname): Update package lists\033[0m"
sudo apt-get update

echo -e "$MSG_COLOR$(hostname): Install PHP-FPM and necessary modules\033[0m"
sudo apt-get install -y php php-fpm php-common php-cli php-mysql php-pgsql php-pdo php-mbstring php-zip zip unzip

echo -e "$MSG_COLOR$(hostname): Install PostgreSQL and its PHP extension\033[0m"
sudo apt-get install -y postgresql postgresql-contrib php-pgsql

echo -e "$MSG_COLOR$(hostname): Create Replication role \033[0m"
sudo -u postgres psql -c "CREATE ROLE replica REPLICATION LOGIN PASSWORD 'mypassword';"

echo -e "$MSG_COLOR$(hostname): Create a new PostgreSQL user and database\033[0m"
sudo -u postgres psql -c "CREATE USER myuser WITH PASSWORD 'mypassword';"
sudo -u postgres psql -c "CREATE DATABASE mydatabase OWNER myuser;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"
sudo -u postgres psql -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO replica;"

# peer access to myuser
# sudo sh -c 'echo "local   all             myuser                                  peer" >> /etc/postgresql/14/main/pg_hba.conf'


cp ../../vagrant/postgres_master/pg_hba.conf /etc/postgresql/14/main/
cp ../../vagrant/postgres_master/postgresql.conf /etc/postgresql/14/main/

sudo service postgresql restart
sudo -u postgres psql -d mydatabase -c "DROP TABLE test;"

echo -e "$MSG_COLOR$(hostname): Import dump.sql and set user privileges\033[0m"
# PGPASSWORD=mypassword sudo -u postgres psql -U myuser -h localhost -d mydatabase -f /vagrant/provision/dump.sql # change to ./provision/dump.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump_sessions_table.sql
sudo -u postgres psql -d mydatabase -f /vagrant/dump_files_table.sql
sudo -u postgres psql -d mydatabase -c "GRANT SELECT, INSERT, UPDATE, DELETE ON TABLE messages TO myuser;" # uneeded?
sudo -u postgres psql -d mydatabase -c "GRANT USAGE, SELECT, UPDATE ON SEQUENCE messages_id_seq TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL PRIVILEGES ON DATABASE mydatabase TO myuser;"
sudo -u postgres psql -d mydatabase -c "GRANT ALL ON messages TO replica;"
sudo -u postgres psql -d mydatabase -c "CREATE PUBLICATION messagepub FOR TABLE messages;"
sudo -u postgres psql -d mydatabase -c "CREATE PUBLICATION datapub FOR TABLE data_table;"
sudo -u postgres psql -d mydatabase -c "CREATE PUBLICATION imagepub FOR TABLE image;"

echo -e "$MSG_COLOR$(hostname): View users and databases in PostgreSQL\033[0m"
sudo -u postgres psql -c "\du"
sudo -u postgres psql -c "\list"
sudo -u postgres psql -d mydatabase -c "\dt"
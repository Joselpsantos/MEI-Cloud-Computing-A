#!/bin/bash
MSG_COLOR="\033[41m"

echo -e "$MSG_COLOR$(hostname): Update package lists\033[0m"
sudo apt-get update

echo -e "$MSG_COLOR$(hostname): Install Apache HTTP Server\033[0m"
sudo apt-get install -y apache2

echo -e "$MSG_COLOR$(hostname): Install PHP-FPM and necessary modules\033[0m"
sudo apt-get install -y php php-fpm php-common php-cli php-mysql php-pgsql php-pdo php-mbstring php-zip zip unzip

# sudo sh -c 'echo -e "<?php\nphpinfo();\n?>" > /var/www/html/phpinfo.php'

sudo systemctl restart apache2

echo -e "$MSG_COLOR$(hostname): Install Composer (PHP)\033[0m"
cd ~
curl -sS https://getcomposer.org/installer -o /tmp/composer-setup.php
sudo php /tmp/composer-setup.php --install-dir=/usr/local/bin --filename=composer

echo -e "$MSG_COLOR$(hostname): Install dependencies for webapp\033[0m"
cd /vagrant/app
sudo -u vagrant bash -c 'composer install'

echo -e "$MSG_COLOR$(hostname): Copy apache config, disable the default site / enable ours\033[0m"
sudo cp /vagrant/provision/projectA.conf /etc/apache2/sites-available/
sudo a2dissite 000-default.conf
sudo a2ensite projectA.conf
sudo systemctl reload apache2

echo -e "$MSG_COLOR$(hostname): Update deploy date @ .env file\033[0m"
cd /vagrant/app
ISO_DATE=$(TZ=Europe/Lisbon date -Iseconds)
sed -i "s/^DEPLOY_DATE=.*/DEPLOY_DATE=\"$ISO_DATE\"/" .env

echo -e "$MSG_COLOR$(hostname): Finished! Visit http://192.168.44.10\033[0m"
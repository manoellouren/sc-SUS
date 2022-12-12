#!/bin/bash

################################################################################
####################     Instalação do sc-SUS com apache2      #################
######################      Manoel Lourenço da Silva       #####################
########################      88 - 9 8135 2456         #########################
################################################################################

#Tira interação do ubuntu 22.04

sudo sed -i 's/#$nrconf{restart} = '"'"'i'"'"';/$nrconf{restart} = '"'"'a'"'"';/g' /etc/needrestart/needrestart.conf

#Instalando Apache2

sudo apt-get update

sudo apt-get upgrade -y

sudo apt install apache2 -y

sudo service apache2 start

echo $"ServerName localhost" >> /etc/apache2/apache2.conf

a2enmod rewrite

sudo apt install libapache2-mod-rpaf -y

service apache2 restart

# Instalação do PHP 8.1

sudo apt install  ca-certificates apt-transport-https software-properties-common -y

sudo add-apt-repository ppa:ondrej/php -y

sudo apt update

sudo apt upgrade -y

sudo apt install php8.1 libapache2-mod-php8.1 -y

service php8.1-fpm start

sudo apt install php8.1-{snmp,memcached,bcmath,fpm,xml,mysql,zip,intl,ldap,gd,cli,bz2,curl,mbstring,pgsql,opcache,soap,cgi,json,gd,memcached} -y

service php8.1-fpm restart

cd /usr/lib/php/20210902

wget https://nuvem.pecaps.com.br/s/zCDqYycRLBxnADE/download/ixed.8.1.lin

cd /etc/php/8.1/apache2

rm php.ini

wget https://nuvem.pecaps.com.br/s/5ebydmjARxBFnE7/download/php.ini

service php8.1-fpm restart

sudo systemctl restart apache2

#Instalação do Banco de Dados MYSQL

sudo apt-get update

sudo apt install mariadb-server mariadb-client -y

sudo systemctl enable mysql

echo "Criar senha para o banco de dados MySQL"

sudo mysql_secure_installation

sudo systemctl restart mysql

service apache2 restart

#Baixando sc-SUS

cd /var/www/

wget https://nuvem.pecaps.com.br/s/keKwPEj8tcwNqtD/download/SCSUS_6-0-20.zip

sudo apt-get install unzip -y

unzip SCSUS_6-0-20.zip

chmod -R 777 /var/www/scsus

rm SCSUS_6-0-20.zip

cd /etc/apache2/sites-enabled/

rm *.conf

wget https://nuvem.pecaps.com.br/s/ioHBkNaPPH8BYXW/download/000-default.conf

sudo apt-get update

sudo apt-get upgrade -y

sudo apt-get autoremove -y

service apache2 restart
service php8.1-fpm restart
service mysql restart


#Instalar PHPadmin WEB

sudo apt install phpmyadmin -y

ln -s /usr/share/phpmyadmin /var/www/html/phpmyadmin

cat /etc/phpmyadmin/config-db.php

echo "Instalação Concluida"

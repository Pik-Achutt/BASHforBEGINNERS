#!/bin/bash
#automate the deployment of kloudone ecomm website
#author Achutt Nair
#declaring functions

function check_service(){
active_or_not=$(systemctl is-active $1))
if[fdactive_or_not="active"]
then
  echo "active"
else
  echo "not active"
  exit 1
 fi


function check_item(){
  if [[ $1 = *$2*]]
    then
      echo "$2 is available"
     else
      echo "$2 is not available"
  fi
  }
  
  
#firewall being set up


echo "Firewalld is being set up"
sudo yum install -y firewalld
sudo service firewalld start
sudo systemctl enable firewalld

#checking fd running or not
check_service firewalld

#Mariadb being set up


echo "Mariadb is being set up"
sudo yum install -y mariadb-server
sudo service mariadb start
sudo systemctl enable mariadb

#MDB up or not
check_service fmariadb
 
 # setting rules for db
 
 
echo "rules are being set up"
sudo firewall-cmd --permanent --zone=public --add-port=3306/tcp
sudo firewall-cmd --reload

#checking if wokring


fd_ports=$(sudo firewall-cmd --list-all --zone=public |grep ports)
if[[$fd_ports = *3306*]]
  echo "3306 configures"
else
  echo "not configured"
  
  #database configuration
  
  
echo "Database being configured"
cat > configure-db.sql <<-EOF
CREATE DATABASE ecomdb;
CREATE USER 'ecomuser'@'localhost' IDENTIFIED BY 'ecompassword';
GRANT ALL PRIVILEGES ON *.* TO 'ecomuser'@'localhost';
FLUSH PRIVILEGES;
EOF

sudo mysql < configure-db.sql

#inventory for database being set up


echo "Inventory is being set up"
cat > db-load-script.sql <<-EOF
USE ecomdb;
CREATE TABLE products (id mediumint(8) unsigned NOT NULL auto_increment,Name varchar(255) default NULL,Price varchar(255) default NULL, ImageUrl varchar(255) default NULL,PRIMARY KEY (id)) AUTO_INCREMENT=1;
INSERT INTO products (Name,Price,ImageUrl) VALUES ("Laptop","100","c-1.png"),("Drone","200","c-2.png"),("VR","300","c-3.png"),("Tablet","50","c-5.png"),("Watch","90","c-6.png"),("Phone Covers","20","c-7.png"),("Phone","80","c-8.png"),("Laptop","150","c-4.png");
EOF

sudo mysql < db-load-script.sql

#checking if mysql running

mysql_db_result=$(sudo mysql -e "use ecomdb; select * from products:")
if[[ $mysql_db_result = *Laptop*]]
then
  echo "running"
else
  echo "inventory not loaded"
  exit 1
fi

#setting web servers for projext


echo "Web servers are being set up"
sudo yum install -y httpd php php-mysql

echo "Firewall is being set up for the server"
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --reload
 
 #checking port 80
 
 
 fd_portss=$(sudo firewall-cmd --list-all --zone=public |grep ports)
if[[$fd_portss = *3306*]]
  echo "3306 configures"
else
  echo "not configured"

sudo sed -i 's/index.html/index.php/g' /etc/httpd/conf/httpd.conf

#setting up HTTPD


echo "Git repo is being set up"
sudo service httpd start
sudo systemctl enable httpd

#checking HTTPD


check_service httpd

#setting up the git repository


echo "setting up the repo"
sudo yum install -y git
sudo git clone https://github.com/kodekloudhub/learning-app-ecommerce.git /var/www/html/

#database replaced with localhost


sudo sed -i 's/172.20.1.101/localhost/g' /var/www/html/index.php

echo "The task is complete"

# checking presence of data on webpage
website=$(curl http://localhost)
for item in Laptop Drone VR Watch
  do
    check_item "$website" $item
    
    

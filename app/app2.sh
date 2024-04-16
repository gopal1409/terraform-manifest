#!/bin/bash
yum update -y
sudo amazon-linux-extras install epel -y
yum update -y
yum install wget -y
yum install nginx -y
yum install git -y
service nginx start
rm -rf /etc/nginx/nginx.conf
cd /etc/nginx/
systemctl restart nginx
sudo amazon-linux-extras install epel -y
sudo yum install mysql -y
sudo yum install mysql-server -y
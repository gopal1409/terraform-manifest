#! /bin/bash
sudo yum update -y
sudo amazon-linux-extras install epel -y
sudo yum update -y
sudo yum install wget -y
sudo yum install nginx -y
sudo yum install git -y
sudo service nginx start
sudo systemctl restart nginx
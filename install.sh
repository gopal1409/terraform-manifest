#! /bin/bash
sudo yum update -y
sudo yum install -y httpd 
sudo systemctl enable httpd 
sudo service httpd start
sudo echo '<h1>welcome to our instantance (hostname)' > /var/www/html/index.html
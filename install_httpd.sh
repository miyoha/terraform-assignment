#!/bin/bash
sudo yum install httpd -y
sudo echo "Automation for the people" > /var/www/html/index.html
sudo systemctl start httpd.service
sudo systemctl enable httpd.service


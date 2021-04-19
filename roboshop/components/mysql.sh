#!/bin/bash
COMPONENT=mysql
source components/common.sh

echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Stat $?

yum remove mariadb-libs -y && yum install mysql-community-server -y
Stat $?

systemctl enable mysqld
systemctl start mysqld

grep temp /var/log/mysqld.log

mysql_secure_installation

mysql -u root -p

> uninstall plugin validate_password;
> ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';

curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"

cd /tmp && unzip mysql.zip && cd mysql-main && mysql -u root -ppassword <shipping.sql


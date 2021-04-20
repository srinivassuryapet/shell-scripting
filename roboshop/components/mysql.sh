#!/bin/bash
COMPONENT=mysql
source components/common.sh

Print "setup mysql repo"
echo '[mysql57-community]
name=MySQL 5.7 Community Server
baseurl=http://repo.mysql.com/yum/mysql-5.7-community/el/7/$basearch/
enabled=1
gpgcheck=0' > /etc/yum.repos.d/mysql.repo
Stat $?

Print "Install mysql"
yum remove mariadb-libs -y && yum install mysql-community-server -y
Stat $?

Print "start mysql"
systemctl enable mysqld
systemctl start mysqld
Stat $?
sleep 30

#mysql_secure_installation

echo "show databases;" | mysql -uroot -ppassword &>/dev/null
if [ $? -ne 0 ]; then
  Print "Grab default mysql password"
  DEFAULT_PASSWORD=$(grep 'temporary password' /var/log/mysqld.log | awk '{print $NF}')
  Stat $?

  Print "Resetting mysql default password"
  mysql --connect-expired-password -uroot -p"${DEFAULT_PASSWORD}" <<EOF
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'Default_RoboShop*999';
  uninstall plugin validate_password;
  ALTER USER 'root'@'localhost' IDENTIFIED BY 'password';
EOF
  Stat $?
fi

Print "Downloading Schema"
curl -s -L -o /tmp/mysql.zip "https://github.com/roboshop-devops-project/mysql/archive/main.zip"
Stat $?

Print "Load Schema"
cd /tmp && unzip -o mysql.zip && cd mysql-main && mysql -u root -ppassword <shipping.sql


#!/bin/bash
COMPONENT=cart
source components/common.sh
Print "Installing nodejs"
yum install nodejs make gcc-c++ -y
Stat $?

Print "Adding roboshop user"
id roboshop || useradd roboshop
Stat $?

Print "Download Cart Code"
curl -s -L -o /tmp/cart.zip "https://github.com/roboshop-devops-project/cart/archive/main.zip"
Stat $?

Print "Extract User Component Code"
rm -rf /home/roboshop/cart && cd /home/roboshop/ && unzip -o /tmp/cart.zip && mv cart-main cart
Stat $?

Print "Install nodejs dependencies"
cd /home/roboshop/cart && npm install --unsafe-perm
Stat $?

chown roboshop:roboshop /home/roboshop -R

Print "Update SystemD script for cart"
sed -i -e 's/REDIS_ENDPOINT/redis-ss.srinivassuryapet.ml/' -e 's/CATALOGUE_ENDPOINT/catalogue-ss.srinivassuryapet.ml/' /home/roboshop/cart/systemd.service && mv /home/roboshop/cart/systemd.service /etc/systemd/system/cart.service
Stat $?

Print "Start cart service"
systemctl daemon-reload && systemctl restart cart && systemctl enable cart
Stat $?
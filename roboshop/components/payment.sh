#!/bin/bash
COMPONENT=payment
source components/common.sh

Print "Installing Python 3"
yum install python36 gcc python3-devel -y
Stat $?

Print "Adding Roboshop user"
id roboshop || useradd roboshop
Stat $?

Print "Download payment code"
rm -rf /home/roboshop/payment && curl -L -s -o /tmp/payment.zip "https://github.com/roboshop-devops-project/payment/archive/main.zip"
Stat $?

Print "Unzip"
cd /home/roboshop && unzip -o /tmp/payment.zip && mv payment-main payment
Stat $?

Print "Installation"
cd /home/roboshop/payment && pip3 install -r requirements.txt
Stat $?

Print "Update user details in payment script"
USER_ID=$(id -u roboshop)
GROUP_ID=$(id -g roboshop)
sed -i -e "/^uid/ c uid=${USER_ID}" -e "/^gid/ c gid=${GROUP_ID}" /home/roboshop/payment/payment.ini

chown roboshop:roboshop /home/roboshop -R

Print "Update systemd file and start payment service"
sed -i -e "s/CARTHOST/cart-ss.srinivassuryapet.ml/" -e "s/USERHOST/user-ss.srinivassuryapet.ml" -e "s/AMQPHOST/rabbitmq-ss.srinivassuryapet.ml" /home/roboshop/payment/systemd.service
mv /home/roboshop/payment/systemd.service /etc/systemd/system/payment.service
systemctl daemon-reload && systemctl enable payment && systemctl start payment
Stat $?








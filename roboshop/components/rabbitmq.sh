#!/bin/bash
COMPONENT=rabbitmq
source components/common.sh

yum list installed | grep esl-erlang
if [ $? -ne 0 ]; then
  Print "Install Erlang"
  yum install https://github.com/rabbitmq/erlang-rpm/releases/download/v23.2.6/erlang-23.2.6-1.el7.x86_64.rpm -y
  Stat $?
fi

Print "Setup Rabbitmq Repos"
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
Stat $?

Print "Install Rabbitmq"
yum install rabbitmq-server -y
Stat $?

Print "Start Rabbitmq"
systemctl enable rabbitmq-server && systemctl start rabbitmq-server
Stat $?

Print "Create application user in rabbitmq"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_user_tags roboshop administrator && rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
Stat $?


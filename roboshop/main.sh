#!/bin/bash
CHECK() {
#  if [ ! -f components/$1.sh ]; then
#	  echo "Given Input does not have a script"
#	  exit 1
#  fi
  if [ "$1" == "all" ]; then
    for component in cart catalogue user shipping payment mongodb redis rabbitmq mysql frontend backend all ; do
      echo "Installing $1 component"
      done
      exit 0
  fi
  echo "Installing $1 Component"
  sleep 1
  exit 0
}
case $1 in
  cart)		    "CHECK $1"; sh components/cart.sh ;;
  catalogue)	"CHECK $1"; sh components/catalogue.sh ;;
  user)		    "CHECK $1"; sh components/user.sh ;;
  shipping)	  "CHECK $1"; sh components/shipping.sh ;;
  payment)	  "CHECK $1"; sh components/payment.sh ;;
  mongodb)	  "CHECK $1"; sh components/mongodb.sh ;;
  redis)	    "CHECK $1"; sh components/redis.sh ;;
  rabbitmq)	  "CHECK $1"; sh components/rabbitmq.sh ;;
  mysql)	    "CHECK $1"; sh components/mysql.sh ;;
  frontend)	  "CHECK $1"; sh components/frontend.sh ;;
  backend)    "CHECK $1"; sh components/backend.sh ;;
  all)        "CHECK $1"; sh components/all.sh ;;
  *)	echo -e "Usage: Invalid Input\eInputs allowed are cart,catalogue,....."
	exit 1
	;;
esac
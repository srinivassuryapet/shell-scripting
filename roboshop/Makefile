help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//'

common:
	@sh components/common.sh

cart: common
cart:	## Install cart component
	@sh components/cart.sh

catalogue: common
catalogue:	## Install catalogue component
	@sh components/catalogue.sh

frontend: common
frontend:	## Install frontend component
	@sh components/frontend.sh

mongodb: common
mongodb:	## Install mongodb component
	@sh components/mongodb.sh

user: common
user:	## Install user component
	@sh components/user.sh

redis: common
redis:  ## Install redis component
	@sh components/redis.sh

mysql: common
mysql:  ## Install mysql component
	@sh components/mysql.sh

shipping: common
shipping:  ## Install shipping component
	@sh components/shipping.sh

rabbitmq: common
rabbitmq:  ## Install rabbitmq component
	@sh components/rabbitmq.sh

payment: common
payment:  ## Install payment component
	@sh components/payment.sh


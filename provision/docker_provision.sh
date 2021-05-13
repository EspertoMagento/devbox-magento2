#!/usr/bin/env bash

set -e

## FOR LAMP STACK
#docker-compose exec web bash /var/www/html/provision/bin/sudo_web_tasks.sh
#docker-compose exec web bash /var/www/html/provision/bin/disable_xdebug.sh
#docker-compose exec web bash /var/www/html/provision/bin/enable_xdebug.sh
#docker-compose exec web bash /var/www/html/provision/bin/utility.sh
#docker-compose exec -u root mysql bash /devbox/provision/bin/db_tasks.sh
#docker-compose exec -u $UID web bash /var/www/html/provision/bin/web_tasks.sh
#docker-compose exec -u $UID web bash /var/www/html/provision/bin/magento_tasks.sh

docker-compose restart

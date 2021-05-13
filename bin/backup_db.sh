#!/usr/bin/env bash

#docker-compose exec -u $UID web bash -c 'mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h mysql $MYSQL_DATABASE > $COMPOSE_PROJECT_NAME.sql'
docker-compose exec -u root mysql bash -c 'mysqldump -u $MYSQL_USER -p$MYSQL_PASSWORD -h mysql $MYSQL_DATABASE > $COMPOSE_PROJECT_NAME.sql'
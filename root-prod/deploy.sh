#!/bin/bash
DBPASS=$1;

#test
#echo ${DBPASS};

# todo(test): clear db before put a data
echo "clearing out the db..."
mysql -h mysql-prod -udrupal -p${DBPASS} -Nse 'show tables' drupal | while read table; do mysql -h mysql-prod -udrupal -p${DBPASS} -e "drop table $table" drupal; done
# import a data
echo "adding a data to the db..."
mysql -h mysql-prod -udrupal -p${DBPASS} drupal < /share/last-dev-db.sql
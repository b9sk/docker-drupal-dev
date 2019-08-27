#!/bin/bash
DBPASS=$1;

# import a data
echo "adding a data to the db..."
mysql -h mysql-dev -udrupal -p${DBPASS} drupal < /share/last-prod-db.sql

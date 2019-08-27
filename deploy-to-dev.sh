#!/bin/bash


# Mandatory user interaction before running the migration
echo -e "\nTHIS ACTION CAN'T BE UNDONE!";
read -p "Do you REALLY want to migrate the site from PROD to DEV? (yes|No): " ANSWER;

if [ -z $ANSWER ] || [ $ANSWER != "yes" ]; then
  echo -e "\nThe job aborted. If you really want to get this done then use \"yes\" word.";
  exit 0;
fi

echo "Processing..."


# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
DBPASS=$(grep MYSQL_PASSWORD mysql.env | awk -F '=' '{print $2}')


# push code changes from dev to prod
echo "rsync..."
rsync -a $DIR/app-prod/ $DIR/app-dev/\
  --exclude sites/all/themes/blanked/node_modules/\
  --exclude \.git/
  #--exclude sites/default/settings.php\


# replace db name in settings.php
echo "sed..."
sed -i "s/'host' => 'mysql-prod'/'host' => 'mysql-dev'/g" $DIR/app-dev/sites/default/settings.php


echo "executing prod:/root/get-dump.sh"
export $DBPASS; docker-compose exec drupal-prod bash -c "/root/get-dump.sh ${DBPASS}"


# make a db backup
echo "executing zip"
DB_TIMESTAMP=$(date +%y%m%d-%H%M);
zip ${DIR}/share/drupal-prod-db_${DB_TIMESTAMP} ${DIR}/share/last-prod-db.sql;


# [dev] import db
# a script that runs inside drupal-dev container
echo "executing dev:/root/import-db.sh"
export $DBPASS; docker-compose exec drupal-dev bash -c "/root/import-db.sh ${DBPASS}"


# [dev] post deploy
echo "setting up dev"
docker-compose exec drupal-dev bash -c "drush cc all"
docker-compose exec drupal-dev bash -c "drush vset theme_debug 1"
docker-compose exec drupal-dev bash -c "drush vset preprocess_js 0"
docker-compose exec drupal-dev bash -c "drush vset preprocess_css 0"

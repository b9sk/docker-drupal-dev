#!/bin/bash
# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
DBPASS=$(grep MYSQL_PASSWORD mysql.env | awk -F '=' '{print $2}')

# [dev] pre deploy
docker-compose exec drupal-dev bash -c "drush cc all"

# push code changes from dev to prod
rsync -av $DIR/app-dev/ $DIR/app-prod/\
  --exclude sites/all/themes/blanked/node_modules/\
  --exclude \.git/
  #--exclude sites/default/settings.php\

# replace db name in settings.php
sed -i "s/'host' => 'mysql-dev'/'host' => 'mysql-prod'/g" $DIR/app-prod/sites/default/settings.php
export $DBPASS; docker-compose exec drupal-dev bash -c "mysqldump -h mysql-dev -udrupal -p${DBPASS} drupal > /share/last-dev-db.sql"

# make a db backup
DB_TIMESTAMP=$(date +%y%m%d-%H%M);
cp ${DIR}/share/last-dev-db.sql ${DIR}/share/${DB_TIMESTAMP}.sql;
zip ${DIR}/share/drupal-dev-db_${DB_TIMESTAMP} ${DIR}/share/${DB_TIMESTAMP}.sql;

# [prod] deploy
# a script that runs inside drupal-prod container
export $DBPASS; docker-compose exec drupal-prod bash -c "/root/deploy.sh ${DBPASS}"

# disable aggregation, enable theme_debug after a db dump
#docker-compose exec drupal-dev bash -c "drush vset maintenance_mode 0"
docker-compose exec drupal-prod bash -c "drush vset theme_debug 0"
docker-compose exec drupal-prod bash -c "drush vset preprocess_js 1"
docker-compose exec drupal-prod bash -c "drush vset preprocess_css 1"
docker-compose exec drupal-prod bash -c "drush cc all"

# remove raw sql-file cause it costs a lot of space
rm ${DIR}/share/${DB_TIMESTAMP}.sql;


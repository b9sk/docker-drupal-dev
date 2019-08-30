#!/bin/bash
# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
DBPASS=$(grep MYSQL_PASSWORD mysql.env | awk -F '=' '{print $2}')
REMOTE_HOST=$(grep REMOTE_HOST my.env | awk -F '=' '{print $2}')


echo -e "local dev -> remote dev: $(date +%Y-%m-%d\ %H:%M)\n$(cat deployment.log)" > deployment.log


echo "INFO: rsync over ssh: locale dev to remote"
rsync -avh -e "ssh -i ./ssh/dev -p 2222" app-dev/ root@${REMOTE_HOST}:/var/www/html/ --exclude \.git/ --exclude sites/all/themes/blanked/node_modules/
sleep 3
# ^ workaround. otherwise ssh gets "Connection refused"


echo "INFO: mysqldump"
docker-compose exec drupal-dev bash -c "mysqldump -h mysql-dev -udrupal -p${DBPASS} drupal | gzip > /share/dev-to-remote-db.sql.gz";
echo "INFO: scp"
scp -i ./ssh/dev -P 2222 ./share/dev-to-remote-db.sql.gz root@${REMOTE_HOST}:/share/
sleep 3


echo "INFO: executing mysql at remote dev"
ssh -i ./ssh/dev -p 2222 root@${REMOTE_HOST} "gunzip -f /share/dev-to-remote-db.sql.gz; mysql -h mysql-dev -udrupal -p${DBPASS} drupal < /share/dev-to-remote-db.sql"


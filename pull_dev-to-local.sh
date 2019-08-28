#!/bin/bash
# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
DBPASS=$(grep MYSQL_PASSWORD mysql.env | awk -F '=' '{print $2}')
REMOTE_HOST=$(grep REMOTE_HOST my.env | awk -F '=' '{print $2}')


echo "INFO: rsync over ssh: remote dev to local"
rsync -avh -e "ssh -i ./ssh/dev -p 2222" root@${REMOTE_HOST}:/var/www/html/ app-dev/ --exclude \.git/
sleep 3


rm share/dev-to-local-db.sql.gz
rm share/dev-to-local-db.sql


echo "INFO: executing remote dev mysqldump"
ssh -i ./ssh/dev -p 2222 root@${REMOTE_HOST} "mysqldump -h mysql-dev -udrupal -p${DBPASS} drupal  | gzip" > share/dev-to-local-db.sql.gz;


# check if previous command was finished properly
DBGZ_SIZE=$(stat --printf="%s" share/dev-to-local-db.sql.gz)

if [[ -e "share/dev-to-local-db.sql.gz" ]] && [[ $DBGZ_SIZE != 0 ]]; then
    echo "INFO: remote mysql dump was saved to local folder: share/dev-to-local-db.sql.gz"
else
    echo "ERROR: share/dev-to-local-db.sql.gz does not exists or empty"
    echo "ERROR: There is some errors occurred. Watch output above."
    exit 1
fi


echo "INFO: pushing the db to local dev"
gunzip -f share/dev-to-local-db.sql.gz
docker-compose exec drupal-dev bash -c "mysql -h mysql-dev -udrupal -p${DBPASS} drupal < /share/dev-to-local-db.sql"
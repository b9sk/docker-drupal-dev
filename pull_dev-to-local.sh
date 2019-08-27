#!/bin/bash
# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
DBPASS=$(grep MYSQL_PASSWORD mysql.env | awk -F '=' '{print $2}')
REMOTE_HOST=$(grep REMOTE_HOST my.env | awk -F '=' '{print $2}')

# @todo: rsync over ssh

rsync -avh -e "ssh -i ./ssh/dev -p 2222" app-dev/ root@${REMOTE_HOST}:/var/www/html/ --exclude \.git/

# todo: remote dev mysql dump
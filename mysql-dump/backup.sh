#!/usr/bin/env bash
USER=$1
PASSWD=$2
DB=$3

if [ -z "${USER}" ] || [ -z "${PASSWD}" ] || [ -z "${DB}" ]; then
    echo -e "\nUsername, Password and Database name must not be empty!"
    echo -e "try: bash $0 db_username username_password db_name\n"
else
    mysqldump -h mysql -u${USER} -p${PASSWD} $DB > /root/mysql-dump/$DB-$(date +%F).sql
fi
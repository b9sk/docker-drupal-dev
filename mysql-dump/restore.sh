#!/usr/bin/env bash
USER=$1
PASSWD=$2
DB=$3
FILE_PATH=$4

if [ -z "${USER}" ] || [ -z "${PASSWD}" ] || [ -z "${DB}" ] || [ -z "${FILE_PATH}" ]; then
    echo -e "\nUsername, Password Database name and path/to/file.sql must not be empty!"
    echo -e "try: bash $0 db_username username_password db_name ./my_backup.sql\n"
else
    mysql -h mysql -u${USER} -p${PASSWD} $DB < $FILE_PATH
fi
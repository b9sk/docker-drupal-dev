#!/bin/bash
DESC=$1

drush --root=/var/www/html cc all
drush --root=/var/www/html vset maintenance_mode 1

DRUSH_FILENAME=$(date +"%Y-%m-%d_%H%M")
drush --root=/var/www/html ard --destination=/root/$DRUSH_FILENAME.tar --description="${DESC}"
drush --root=/var/www/html vset maintenance_mode 0

printf "\nJob done\n========\n"

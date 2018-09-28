# docker-drupal7-dev
Development environment for Drupal 7 with Drush and Composer.

## todo
* xDebug
* ssh 402222

* Clone the repo
* Get inside `docker-drupal-dev/`
* Create `app/` dir and place there the lastest release [of Drupal 7](https://www.drupal.org/project/drupal)
* Give full access to `www-data` user inside `drupal_dev` container. For example run:
  + `find ./ -type f -print | xargs chmod 666`
  + `find ./ -type d -print | xargs chmod 777`
* Go to parent folder and run `docker-compose -f ./docker-compose.dev.yml up -d`
* Open in a browser url `http:://docker_host_machine_ip:40080`
* Install Drupal manually OR by using the script: `~/scripts/install-drupal.sh` (run this from `drupal-dev` container)
* (Optional) Convert your DB to utf8mb4: [Database 4 byte UTF-8 support](https://www.drupal.org/project/utf8mb4_convert)

## Notes
* mysql db, user and password: `drupal`
* mysql host: `mysql`
* run `docker exec -it drupal-dev bash` from docker host machine to dive into `drupal-dev` container
* [Database 4 byte UTF-8 support](https://www.drupal.org/project/utf8mb4_convert)

## Volumes structure
* ./app:/var/www/html - drupal codebase
* ./drush-backup:/root/drush-backup - backups maked by ./drush-backup/make-backup.sh
* ./mysql-dump:/root/mysql-dump - your \*.sql files
* ./scripts:/root/scripts

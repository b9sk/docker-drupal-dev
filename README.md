# docker-drupal7-dev
Development environment for Drupal 7 with Xdebug, Drush and Composer.


## How to

### Run the services
* Clone the repo
* Get inside `docker-drupal-dev/`
* Create `app/` dir and place there the lastest release [of Drupal 7](https://www.drupal.org/project/drupal)
* Setup Xdedug (see below)
* Go to parent folder and run `docker-compose -f ./docker-compose.dev.yml up -d`
* Open in a browser url `http:://docker_host_machine_ip:30080`
* Install Drupal manually OR by use the script: `~/scripts/install-drupal.sh` (run this from `drupal-dev` container)
* (Optional) Convert your DB to utf8mb4: [Database 4 byte UTF-8 support](https://www.drupal.org/project/utf8mb4_convert)

### Setup Xdedug
* Find `xdebug.remote_host=` and replace an IP by `xdebug.remote_host=your_docker_host_ip`
* Set up DBGp Proxy:
* + IDE Key: `mySecretKey666`
* + Host: `your_docker_host_ip`
* + Port: `39000`

### Get SSH access
* Run `ssh -i ssh/php-container -p 30022 root@your_docker_host_ip` from the project folder  
**Warning!** This approach may have security issues. Run with caution.

### Port forward (if you app does not support DBGp Proxy)
* `ssh -vR 9000:localhost:9000 -i ssh/php-container -p 30022 root@your_docker_host_ip`


## Notes
* mysql db, user and password: `drupal`
* mysql host: `mysql`
* run `docker exec -it drupal-dev bash` from docker host machine to dive into `drupal-dev` container
* [Database 4 byte UTF-8 support](https://www.drupal.org/project/utf8mb4_convert)


## Volumes structure
* ./app:/var/www/html - drupal codebase
* ./drush-backup:/root/drush-backup - backups maked by ./drush-backup/make-backup.sh
* ./mysql-dump:/root/mysql-dump - your \*.sql files

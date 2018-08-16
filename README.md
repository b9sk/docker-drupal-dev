# docker-drupal8-dev
Development environment for Drupal 8 with Drush and Composer.

* Clone the repo
* Get inside `docker-drupal8-dev/`
* Create `app/` dir and place there the lastest release [of Drupal 8](https://www.drupal.org/project/drupal)
* Give full access to `www-data` user inside `drupal_dev` container. For example run:
  + `find ./ -type f -print | xargs chmod 666`
  + `find ./ -type d -print | xargs chmod 777`
* Go to parent folder and run `docker-compose up -d`
* Open in a browser url `http:://docker_host_machine_ip:45080`
* Install Drupal manually

## Notes
* mysql db, user and password: `drupal`
* mysql host: `mysql`
* run `docker exec -it drupal_dev bash` from docker host machine to dive into `drupal_dev` container

## todo
* see Dockerfile

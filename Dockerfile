FROM drupal:7-apache
WORKDIR /var/www/html

# Utils
RUN apt-get update -q && apt-get install -yqq mysql-client

# Cleaning up local apt repository
RUN rm -rf /var/lib/apt/lists/*

COPY drush-backup/ /root/drush-backup/
RUN chmod +x /root/drush-backup/make-backup.sh

# Full access for www-data
RUN chmod -R 777 /var/www/html; echo "umask 000" >> /root/.bashrc

EXPOSE 80

CMD ["apache2-foreground"]

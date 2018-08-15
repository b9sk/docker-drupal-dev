# Drupal 8 development codebase ENV #

FROM drupal:8-apache
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Install Drush 8 (master) as phar.
RUN curl https://github.com/drush-ops/drush/releases/download/8.1.17/drush.phar -L -o /usr/local/bin/drush && \
    chmod +x /usr/local/bin/drush

# Install mysql client (a Drush dependency)
RUN apt update && apt install mysql-client -y

RUN apt install git vim -y
RUN rm -rf /var/lib/apt/lists/*

# Give full access to www-data for mounted volumes and new files
RUN echo "umask 000" >> /root/.bashrc

EXPOSE 80

# todo: pecl install xdebug

# vim:set ft=dockerfile:

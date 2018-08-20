FROM drupal:7-apache
WORKDIR /var/www/html

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && chmod +x /usr/local/bin/composer

# Install Drush 8 (master) as phar.
RUN curl https://github.com/drush-ops/drush/releases/download/8.1.17/drush.phar -L -o /usr/local/bin/drush && \
    chmod +x /usr/local/bin/drush

# Install mysql client (a Drush dependency)
RUN apt-get update -q && apt-get install -yq mysql-client
RUN apt-get install -yq vim iputils-ping

# Xdebug DBGp-proxy
#RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -yq install python-pip
#RUN pip2 install komodo-python-dbgp

# Cleaning up local apt repository
#RUN apt-get -qy autoremove && DEBIAN_FRONTEND=noninteractive apt-get -yq clean
RUN rm -rf /var/lib/apt/lists/*

# Install xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug

# Add xdebug.ini settings
RUN printf "\nxdebug.remote_enable=1\n\
xdebug.remote_autostart=1\n\
xdebug.remote_handler=dbgp\n\
xdebug.remote_mode=req\n\
xdebug.remote_host=127.0.0.1\n\
xdebug.remote_port=9000\n\
xdebug.idekey=mySecretKey666\n\
" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini

# (possible useless) Give full access to www-data for mounted volumes and new files
RUN echo "umask 000" >> /root/.bashrc

EXPOSE 80 9000 


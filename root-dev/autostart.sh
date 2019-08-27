#!/bin/bash
# create|clear xdebug.log on container start
echo "" | tee /var/www/html/xdebug.log

apache2-foreground &
/usr/sbin/sshd -d -D

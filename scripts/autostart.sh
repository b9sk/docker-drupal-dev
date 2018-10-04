#!/bin/bash
# create|clear xdebug.log
echo "" | tee /var/www/html/xdebug.log


apache2-foreground &
/usr/sbin/sshd -D

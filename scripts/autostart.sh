#!/bin/bash
apache2-foreground &
/usr/sbin/sshd -D

if [ ! -f "/var/www/html/xdebug.log" ]; then
	touch /var/www/html/xdebug.log
fi
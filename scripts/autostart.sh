#!/bin/bash
# create|clear xdebug.log
echo "" | tee /var/www/html/xdebug.log

apache2-foreground &
/usr/local/bin/pydbgpproxy -d 0.0.0.0:9000 -i 0.0.0.0:9001 &
/usr/sbin/sshd -D

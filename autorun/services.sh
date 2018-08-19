#!/bin/sh
/usr/local/bin/pydbgpproxy -d 127.0.0.1:9000 -i 127.0.0.1:9001 &
apache2-foreground

#!/bin/bash
# init
DIR=$(dirname "${BASH_SOURCE[0]}")
cd $DIR
REMOTE_HOST=$(grep REMOTE_HOST my.env | awk -F '=' '{print $2}')

# Port forwarding for Xdebug
ssh -R localhost:9000:localhost:9000 -v -i ./ssh/dev -p 2222 root@${REMOTE_HOST}
#!/bin/bash
# Add docker.host.internal to /etc/hosts if the domain is not exist yet

STR=$(cat /etc/hosts | grep "docker.host.internal")

echo $STR;

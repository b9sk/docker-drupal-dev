#!/bin/bash
DBPASS=$1;
mysqldump -h mysql-prod -udrupal -p${DBPASS} drupal > /share/last-prod-db.sql

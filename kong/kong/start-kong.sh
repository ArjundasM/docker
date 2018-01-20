#!/bin/bash
service postgresql start 
kong migrations up [-c /etc/kong/kong.conf]
kong start [-c /etc/kong/kong.conf] 
nohup kong-dashboard start --kong-url http://localhost:8001 --port 16000 & 
curl -i -X POST \
     --url http://localhost:8001/apis/ \
     --data 'name=Base-Route' \
     --data 'hosts=localhost' \
     --data 'uris=/' \
     --data 'methods=GET,POST,PUT,PATCH,DELETE,OPTIONS,HEAD' \
     --data 'upstream_url=http://localhost:9999' 
while true; do sleep 1000; done 


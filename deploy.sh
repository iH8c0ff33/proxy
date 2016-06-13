#!/bin/sh
docker build -t proxy_image /var/proxy
docker kill proxy
docker rm proxy
docker create --restart=always \
  -i -t \
  -p 80:80 \
  -p 443:443 \
  -v /var/certs:/var/certs \
  --name proxy \
  proxy_image
docker network connect webserver_default proxy
docker network connect mailserver proxy
docker network connect regapp_network proxy
docker start proxy
echo nothing
echo nothing

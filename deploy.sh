#!/bin/sh
docker rmi proxy_image
docker build -t proxy_image /var/proxy
docker stop proxy
docker rm proxy
docker create --restart=always \
  -i -t \
  -p 80:80 \
  -p 443:443 \
  -v /var/certs:/var/certs \
  --name proxy \
  --net webserver_default \
  --net mailserver \
  --net regapp_network \
  proxy_image
docker start proxy

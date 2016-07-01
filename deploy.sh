#!/bin/sh
docker build -t proxy_image . || \
    (echo "ERR: proxy build failed" && \
    exit 1)
docker inspect proxy &> /dev/null && \
    docker kill proxy && docker rm proxy || \
    echo "proxy seems to be already stopped"
docker create --restart=always \
  -i -t \
  -p 80:80 \
  -p 443:443 \
  -v /var/certs:/var/certs \
  --name proxy \
  proxy_image
docker start proxy

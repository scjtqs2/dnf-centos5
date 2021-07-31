#!/bin/zsh
# docker network create --subnet=172.18.0.0/16 mynetwork
docker run --rm -it --network mynetwork --ip 172.18.0.10 -e PublicIp=172.18.0.10 -v "`pwd`/mysql/":/home/data/ -p 3316:3306 scjtqs/dnf-centos5:test
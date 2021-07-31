#!/bin/zsh
# docker network create --subnet=172.18.0.0/16 mynetwork
docker run --rm -it --network host -e PublicIp=172.18.0.10 -v "`pwd`/mysql/":/home/data/  scjtqs/dnf-centos5:latest
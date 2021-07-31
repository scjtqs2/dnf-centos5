#!/bin/zsh
docker build --no-cache --rm -t scjtqs/dnf-centos5:latest .
docker push scjtqs/dnf-centos5:latest
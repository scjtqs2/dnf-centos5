FROM scjtqs/dnf-centos5-base:latest

ARG PublicIp=127.0.0.1
ENV PublicIp=${PublicIp}

COPY init.sh /
COPY run.sh /
COPY sed.php /
RUN /bin/bash /init.sh

ENTRYPOINT ["/run.sh"]
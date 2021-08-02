FROM scjtqs/centos5:latest

ENV PublicIp=127.0.0.1
ENV UDP_IP=127.0.0.1
ENV DB_HOST=127.0.0.1
ENV DB_USER=game
ENV DB_KEY=20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b
ENV DB_PASS=uu5!^%jg

## 数据库的数据存储位置
#ENV DIRECTORY=/home/data/

COPY DnfServer.tar.gz /
COPY entrypoint.sh /
COPY Script.pvf /src/
COPY df_game_r /src/
COPY publickey.pem /src/
COPY run.sh /root/
#COPY stop.sh /root/
COPY sed.php /root/
#ENV TINI_VERSION v0.19.0
#ADD https://ghproxy.com/https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini-static /tini
#COPY my.cnf /opt/etc/

#复制统一登录器
COPY tongyi-5.8/Config.ini /root/
COPY tongyi-5.8/DnfGateServer /root/
COPY tongyi-5.8/GateRestart /root/
COPY tongyi-5.8/GateStop /root/
COPY tongyi-5.8/privatekey.pem /root/

WORKDIR /root/

RUN tar -zxvf /DnfServer.tar.gz -C / \
    && rm -rf /DnfServer.tar.gz \
#   数据库独立出去，镜像中的mysql数据库可以删了.
    && rm -rf /opt/lampp \
    && rm -rf /var/lib/mysql \
    && chmod +x /entrypoint.sh \
    && chmod -R +x /root/
#    && chmod +x /tini

# PORT
EXPOSE 2311
EXPOSE 2312
EXPOSE 2313
#EXPOSE 3306
EXPOSE 7000
EXPOSE 7001
EXPOSE 7200
EXPOSE 8000
EXPOSE 8100
EXPOSE 9006
EXPOSE 10001
EXPOSE 10011
EXPOSE 10056
EXPOSE 11011
EXPOSE 11056
EXPOSE 30403
EXPOSE 31003
EXPOSE 31100

#ENTRYPOINT ["/tini", "--","/entrypoint.sh"]
ENTRYPOINT ["/entrypoint.sh"]
#ENTRYPOINT ["/tini", "--","bash"]

#CMD []
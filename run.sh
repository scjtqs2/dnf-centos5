#!/bin/bash
#判断neople是否安装
setenforce 0
if [ -f /home/neople/install.lock ];then
    echo "neople is installed"
#    cd /  &&  tar -zxvf Service.tar.gz
    chmod -R 777 /home
    chmod -R 777 /root
    touch /home/neople/install.lock
else
    tar -zxvf /DNFServer.tar.gz -C /
    mv /pvf/df_game_r /home/neople/game/
    mv /pvf/publickey.pem /home/neople/game/
    mv /pvf/Script.pvf /home/neople/game/
    chmod -R 777 /home
    chmod -R 777 /root
    touch /home/neople/install.lock
    /usr/bin/php /sed.php
fi
#判断mysql是否安装
if [ -f /opt/lampp/var/mysql/install.lock ];then
    echo "mysqld is installed"
    chmod -R 777 /home
    chmod -R 777 /root
    chmod -R 777 /opt/lampp/var/mysql/
    touch /opt/lampp/var/mysql/install.lock
else
    tar -zxvf /XAMPP.tar.gz -C /
    chmod -R 777 /home
    chmod -R 777 /root
    chmod -R 777 /opt/lampp/var/mysql/
    touch /opt/lampp/var/mysql/install.lock
fi
/opt/lampp/lampp start
sleep 5
/root/run
/bin/bash

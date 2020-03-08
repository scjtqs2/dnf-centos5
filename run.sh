#!/bin/bash
#判断neople是否安装
setenforce 0
if [ -f /home/neople/install.lock ];then
    echo "neople is installed"
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
#清理缓存
find /home/ -name '*.log' -type f -print -exec rm -f {} \;
find /home/ -name '*.pid' -type f -print -exec rm -f {} \;
find /home/ -name '*.MMAP' -type f -print -exec rm -f {} \;
find /home/ -name 'core*' -type f -print -exec rm -f {} \;
#判断mysql是否安装
if [ -f /opt/lampp/var/mysql/install.lock ];then
    echo "mysqld is installed"
    chmod -R 777 /home
    chmod -R 777 /root
    chmod -R 777 /opt/lampp/var/mysql/
#    chown -R mysql:mysql /opt/lampp/var/mysql/
    touch /opt/lampp/var/mysql/install.lock
else
    tar -zxvf /XAMPP.tar.gz -C /
    chmod -R 777 /home
    chmod -R 777 /root
    touch /opt/lampp/var/mysql/install.lock
    /opt/lampp/lampp/bin/mysql_upgrade -ugame -p'uu5!^%jg'
fi
/bin/cp -rf /my.cnf /opt/lampp/etc/
/opt/lampp/lampp restart
sleep 5
/opt/lampp/lampp/bin/mysqladmin -ugame -p'uu5!^%jg' flush-hosts
/root/run
/bin/bash

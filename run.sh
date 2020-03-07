#!/bin/bash
#判断neople是否安装
if [ -f /home/neople/install.lock ];then
    echo "neople is installed"
#    cd /  &&  tar -zxvf Service.tar.gz
    chmod -R 777 /var/lib/mysql
    chmod -R 777 /home
    chmod -R 777 /root
    touch /home/neople/install.lock
else
    cd /  && tar -zxvf DNFServer.tar.gz
    chmod -R 777 /var/lib/mysql
    chmod -R 777 /home
    chmod -R 777 /root
    touch /home/neople/install.lock
    /usr/bin/php /sed.php
fi
#判断mysql是否安装
if [ -f /var/lib/mysql/install.lock ];then
    echo "mysqld is installed"
    chmod -R 777 /var/lib/mysql
    chmod -R 777 /home
    chmod -R 777 /root
    touch /home/neople/install.lock
else
    rm -rf /var/lib/mysql
    cd / &&  tar -zxvf MySQL.tar.gz
    # 在 /etc/my.cnf 中加入 default-storage-engine=InnoDB
    # 删除var/lib/mysql/目录下的ib_logfile0，ib_logfile1
#    rm /var/lib/mysql/ib_logfile0 && rm /var/lib/mysql/ib_logfile1
    chmod -R 777 /var/lib/mysql
    chmod -R 777 /home
    chmod -R 777 /root
    service mysqld start
    chkconfig mysqld on
    service mysqld stop
    #启动mysqld
    service mysqld start
    mysql_upgrade -u game -p'uu5!^%jg'
    touch /var/lib/mysql/install.lock
fi
service mysqld restart
/root/run
/bin/bash

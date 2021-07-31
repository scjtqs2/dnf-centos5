#!/bin/bash

## 替换配置信息
#MySQL IP    mysql host
#MySQL Name  mysql user
#MySQL Key   mysql pass
#Public IP   public ip
#MySQL PWD   明文密码
sed -i "s/Public IP/$PublicIp/g" `find /home/neople/ -type f -name "*.cfg"`
sed -i "s/UDP IP/$UDP_IP/g" `find /home/neople/ -type f -name "*.cfg"`
sed -i "s/MySQL IP/$DB_HOST/g" `find /home/neople/ -type f -name "*.cfg"`
sed -i "s/MySQL Name/$DB_USER/g" `find /home/neople/ -type f -name "*.cfg"`
sed -i "s/MySQL Key/$DB_KEY/g" `find /home/neople/ -type f -name "*.cfg"`
sed -i "s/MySQL PWD/$DB_PASS/g" `find /home/neople/ -type f -name "*.cfg"`

sed -i "s,{DIRECTORY},$DIRECTORY,g" /opt/etc/my.cnf

#DIRECTORY=/home/data/
mkdir -p $DIRECTORY
if [ "`ls -A $DIRECTORY`" = "" ]; then
  echo "$DIRECTORY is indeed empty"
  /bin/cp -af /opt/lampp/var/mysql $DIRECTORY
else
  echo "$DIRECTORY is not empty"
fi


#启动mysql
chmod +x /opt/lampp/lampp
/opt/lampp/lampp start

sleep 20

# 替换 Script.pvf
/bin/cp -rf /src/Script.pvf /home/neople/game/
# 替换 df_game_r
/bin/cp -rf /src/df_game_r /home/neople/game/
# 替换 publickey.pem 统一登录器的
/bin/cp -rf /root/publickey.pem /home/neople/game/

# 替换db中的参数
php /root/sed.php

/root/run.sh


#启动统一登录器
cd /root && ./GateRestart

sleep 10
cat /root/gate.log

# 挂起进程
#while true; do
#    sleep 100
#done
/bin/bash
# dnf-centos5
这个 dnf私服 的服务端 

mysql 用户名：game 密码：uu5!^%jg

集成了统一登录器 5.8的服务端。默认配置查看 tongyi-5.8/Config.ini

运行docker前，请确保你的swap分区容量足够。推荐直接上8G swap

> 如果使用了独立的数据库，并导入了初始化的库和表，可以自行修改 `DB_HOST`,`DB_USER`，`DB_KEY`，`DB_PASS`
>
> 初始化mysql的sql文件是 db.sql。默认创建用户：`game`、密码：`uu5!^%jg`。以及对应的库。 
> 


使用 host模式跑
```bash
dcker run -it --rm --name dnf --net=host --privileged=true --memory=8g --oom-kill-disable --shm-size=8g \
-e PublicIp=你的公网ip 或者机器局域网Ip \
-e UDP_IP=你的UDP转发IP \
-e DB_HOST=127.0.0.1 \
-e DB_USER=game \
-e DB_KEY=20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b \
-e DB_PASS=uu5!^%jg \
-v /你自己的pvf/Script.pvf:/src/Script.pvf \
-v /root/db/:/home/data/ \
-v /你自己的等级补丁/df_game_r:/src/df_game_r  \
scjtqs/dnf-centos5
```
使后台跑
```bash
dcker run -itd --rm --name dnf --net=host --privileged=true --memory=8g --oom-kill-disable --shm-size=8g \
-e PublicIp=你的公网ip 或者机器局域网Ip \
-e UDP_IP=你的UDP转发IP \
-e DB_HOST=127.0.0.1 \
-e DB_USER=game \
-e DB_KEY=20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b \
-e DB_PASS=uu5!^%jg \
-v /你自己的pvf/Script.pvf:/src/Script.pvf \
-v /root/db/:/home/data/ \
-v /你自己的等级补丁/df_game_r:/src/df_game_r  \
scjtqs/dnf-centos5
```

```bash
docker run -it --name dnf --privileged=true --memory=8g --oom-kill-disable --shm-size=8g \
-e PublicIp=你的公网ip 或者机器局域网Ip \
-e UDP_IP=你的UDP转发IP \
-e DB_HOST=127.0.0.1 \
-e DB_USER=game \
-e DB_KEY=20e35501e56fcedbe8b10c1f8bc3595be8b10c1f8bc3595b \
-e DB_PASS=uu5!^%jg \
-v /你自己的pvf/Script.pvf:/src/Script.pvf \
-v /root/db/:/home/data/ \
-v /你自己的等级补丁/df_game_r:/src/df_game_r  \
-p 2311-2313:2311-2313/tcp \
-p 2311-2313:2311-2313/udp \
-p 7000-7001:7000-7001/udp \
-p 7000-7001:7000-7001/tcp \
-p 7200-7201:7200-7201/tcp \
-p 7200-7201:7200-7201/udp \
-p 8000:8000/tcp \
-p 8000:8000/udp \
-p 8100:8100/tcp \
-p 8100:8100/udp \
-p 9006:9006/tcp \
-p 9006:9006/udp \
-p 10001:10001/tcp \
-p 11001:11001/udp \
-p 10031:10031/tcp \
-p 11031:11031/udp \
-p 10011:10011/tcp \
-p 11011:11011/udp \
-p 10052:10052/tcp \
-p 11052:11052/udp \
-p 10056:10056/tcp \
-p 11056:11056/udp \
-p 20017-20018:20017-20018/tcp \
-p 20017-20018:20017-20018/udp \
-p 20203:20203/tcp \
-p 20203:20203/udp \
-p 20303:20303/tcp \
-p 20303:20303/udp \
-p 20403:20403/tcp \
-p 20403:20403/udp \
-p 30303:30303/tcp \
-p 30303:30303/udp \
-p 30403:30403/tcp \
-p 30403:30403/udp \
-p 30503:30503/udp \
-p 20603:30603/tcp \
-p 30603:30603/udp \
-p 30703:30703/udp \
-p 30803:30803/tcp \
-p 30803:30803/udp \
-p 31003:31003/tcp \
-p 31003:31003/udp \
-p 31100:31100/tcp \
-p 40403:40403/tcp \
-p 40403:40403/udp \
scjtqs/dnf-centos5
```

# 直接用docker-compose跑
```bash
mkdir -p db
#修改好 docker-compose.yml的配置
docker-compose up -d
# 查看日志情况。
docker logs -f dnf 
```
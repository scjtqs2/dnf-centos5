# dnf-centos5
这个 dnf私服 的服务端 

mysql 用户名：game 密码：uu5!^%jg

集成了统一登录器 5.8的服务端。默认配置查看 tongyi-5.8/Config.ini

运行docker前，请确保你的swap分区容量足够。推荐直接上8G swap

> 如果使用了独立的数据库，并导入了初始化的库和表，可以自行修改 `DB_HOST`,`DB_USER`，`DB_KEY`，`DB_PASS`
>
> 初始化mysql的sql文件是 db.sql。默认创建用户：`game`、密码：`uu5!^%jg`。以及对应的库。 
> 

## 一、docker 方式 （建议用dokcer-compose的方式）

### 1、启动一个db 

```bash 
docker run --name some-mysql --net=host \
-v /root/dnf-centos5/mysql:/var/lib/mysql \
-v /root/dnf-centos5/db.sql:/docker-entrypoint-initdb.d/init.sql
-e MYSQL_ROOT_PASSWORD=my-secret-pw \
-d mysql:5.5
```

### 2、使用 host模式跑（用于调试）
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
### 2、使后台跑 （正式）
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

# 直接用docker-compose跑
```bash
mkdir -p mysql
#修改好 docker-compose.yml的配置
docker-compose up -d
# 查看日志情况。
docker logs -f dnf 
```
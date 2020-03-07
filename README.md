# dnf-centos5
这个 dnf私服 的服务端

如果运行下面代码，服务端文件会存在 /root/docker-dnf/data/home 下，对应的mysql文件存于 /root/docker-dnf/data/mysql

为了避免冲突，我将mysql映射为了3310端口，有其他需要的自行修改。 mysql 用户名：game 密码：uu5!^%jg

跑完一次后，会生成对应的文件夹。之后你可以停止docker stop dnf 然后替换掉里面的 秘钥和pvf文件之类的。再启动

运行docker前，请确保你的swap分区容量足够。推荐直接上8G swap

```bash
docker run -it --name dnf   -v /root/docker-dnf/data/home:/home \
    -v /root/docker-dnf/data/mysql:/opt/lampp/var/mysq \
        -p 3310:3306/tcp \
        -p 7001:7001/tcp \
        -p 7000:7000/udp \
        -p 7200:7200/tcp \
        -p 7200:7200/udp \
        -p 10001:10001/tcp \
        -p 10031:10031/tcp \
        -p 11011:10011/udp \
        -p 11031:10031/udp \
        -p 31003:31003/tcp \
        -p 31003:31003/udp \
        -p 9006:9006/tcp \
        -p 9006:9006/udp \
        -p 2311:2311/tcp \
        -p 2311:2311/udp \
        -p 2312:2312/tcp \
        -p 2312:2312/udp \
        -p 2313:2313/tcp \
        -p 2313:2313/udp \
        -p 10006:10006/tcp \
        -p 11006:11006/udp \
        -p 10015:10015/tcp \
        -p 11015:11015/udp \
        -p 10056:10056/tcp \
        -p 11056:11056/udp \
    -e PublicIp=你的公网ip 或者机器局域网Ip \
    scjtqs/dnf-centos5
```
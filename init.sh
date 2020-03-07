#!/bin/bash
#yum -y update
#yum -y install xulrunner.i386 libXtst.i386
#yum -y install mysql-server mysql mysql-devel
yum clean all
service mysqld start
service mysqld stop
chmod +x /run.sh
cd / &&  tar -zxvf Service.tar.gz
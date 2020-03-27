#!/bin/bash

echo "安装Redis"
yum -y install tcl tcl-devel
mkdir -p /data/backup/redis
cd /data/src
wget http://download.redis.io/releases/redis-5.0.5.tar.gz
tar zxvf redis-5.0.5.tar.gz
cd redis-5.0.5 && make && make install
\cp -rp redis.conf /etc/
sed -i 's/daemonize no/daemonize yes/g' /etc/redis.conf
sed -i 's/dir .\//dir \/data\/backup\/redis\//g' /etc/redis.conf
sed -i '/# maxmemory <bytes>/amaxmemory 2147483648' /etc/redis.conf
sed -i 's/^bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis.conf

cp /data/src/service_redis.sh /etc/init.d/redis
chmod +x /etc/init.d/redis
service redis start

chkconfig --add redis
chkconfig redis on
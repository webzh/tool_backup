#!/bin/bash

echo "安装Redis"
yum -y install tcl tcl-devel
mkdir -p /data/backup/redis
cd /data/src
tar zxvf redis-3.2.11.tar.gz
cd redis-3.2.11 && make && make install
\cp -rp redis.conf /etc/
sed -i 's/daemonize no/daemonize yes/g' /etc/redis.conf
sed -i 's/dir .\//dir \/data\/backup\/redis\//g' /etc/redis.conf
sed -i '/# maxmemory <bytes>/amaxmemory 2147483648' /etc/redis.conf
sed -i 's/^bind 127.0.0.1/# bind 127.0.0.1/g' /etc/redis.conf

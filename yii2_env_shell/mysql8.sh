#!/bin/bash
echo "支持lz4 压缩算法，mysql 8 mysqlpump 导出 指定算法"
yum -y install epel-release lz4 lz4-devel ncurses-devel bison openssl-devel

echo "建立mysql用户及数据存放目录"

groupadd mysql && useradd -g mysql -s /sbin/nologin mysql
mkdir -p /data/local/mysql8
mkdir -p /etc/my8
mkdir -p /data/src
mkdir -p /data/mysql8db/3307
mkdir -p /data/mysql8db/binlog
mkdir -p /data/mysql8db/run
mkdir -p /data/mysql8db/logs
chown -R mysql:mysql /data/mysql8db

echo "安装Cmake"

cd /data/src
tar zxvf cmake-3.8.0.tar.gz && cd ./cmake-3.8.0

./configure --prefix=/data/local/cmake && make && make install

echo "安装MySQL"
cd /data/src
wget https://dev.mysql.com/get/Downloads/MySQL-8.0/mysql-boost-8.0.31.tar.gz
tar zxvf mysql-boost-8.0.31.tar.gz && cd mysql-8.0.31/
/data/local/cmake/bin/cmake \
-DWITH_BOOST=./boost/ \
-DCMAKE_C_COMPILER=/usr/bin/gcc \
-DCMAKE_CXX_COMPILER=/usr/bin/g++ \
-DCMAKE_INSTALL_PREFIX=/data/local/mysql8 \
-DMYSQL_DATADIR=/data/mysql8db \
-DMYSQL_UNIX_ADDR=/data/mysql8db/run/mysql3307.sock \
-DSYSCONFDIR=/etc/my8 \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3307 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DWITH_DEBUG=0 \
-DWITHOUT_FEDERATED_STORAGE_ENGINE=1 \
-DWITHOUT_ARCHIVE_STORAGE_ENGINE=1 \
-DFORCE_INSOURCE_BUILD=1

make j4 && make install

make clean

#\cp support-files/mysql.server /etc/init.d/mysqld
#chmod +x /etc/init.d/mysqld
#chkconfig --add mysqld
#chkconfig mysqld on

ln -s /data/local/mysql8 /usr/local/mysql8
ln -s /data/local/mysql8/bin/mysql /usr/local/sbin/mysql8
chown -R mysql:mysql /data/mysql8db

echo "Mysql安装完毕"

echo "初始化mysql数据 请执行 /data/local/mysql8/bin/mysqld --defaults-file=/etc/my8/my.cnf --basedir=/data/local/mysql8 --datadir=/data/mysql8db/3307 --user=mysql --initialize "
#注意没有设定 my.cnf 的情况下，直接输出到控制台，显示初始化的密码
#/data/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/data/local/mysql --datadir=/data/mysqldb/3306


#多线程 压缩 导出数据库
#/usr/local/mysql/bin/mysqlpump -uroot -p -S /data/mysqldb/run/mysql3306.sock --compress-output=LZ4
#--default-parallelism=4 --databases cod > cod.lz4
# GRANT REPLICATION SLAVE ON *.* TO 'rep_slave'@'x.x.x.x' IDENTIFIED BY '123456';
# GRANT REPLICATION SLAVE ON *.* TO 'rep_slave'@'x.x.x.x' IDENTIFIED BY '123456';

echo "新版MySQLpump权限"
#GRANT SELECT,RELOAD,LOCK TABLES,SHOW DATABASES,SHOW VIEW,EXECUTE,EVENT,TRIGGER
#ON *.* TO 'backup'@'127.0.0.1' IDENTIFIED BY '123456';
#
#

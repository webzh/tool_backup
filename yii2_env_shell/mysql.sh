#!/bin/bash
echo "支持lz4 压缩算法，mysql 5.7 mysqlpump 导出 指定算法"
yum -y install gcc-c++ epel-release lz4 lz4-devel

echo "建立mysql用户及数据存放目录"

groupadd mysql && useradd -g mysql -s /sbin/nologin mysql
mkdir -p /data/local
mkdir -p /data/src
mkdir -p /data/mysqldb/3306
mkdir -p /data/mysqldb/binlog
mkdir -p /data/mysqldb/run
mkdir -p /data/mysqldb/logs
chown -R mysql:mysql /data/mysqldb

echo "安装Cmake"

cd /data/src
tar zxvf cmake-3.8.0.tar.gz && cd ./cmake-3.8.0

./configure --prefix=/data/local/cmake && make && make install

echo "解压boost"

cd /data/src
tar zxvf boost_1_59_0.tar.gz

echo "安装MySQL"
cd /data/src
tar zxvf mysql-5.7.22.tar.gz && cd mysql-5.7.22
/data/local/cmake/bin/cmake  \
-DCMAKE_INSTALL_PREFIX=/data/local/mysql \
-DMYSQL_DATADIR=/data/mysqldb \
-DMYSQL_UNIX_ADDR=/data/mysqldb/run/mysql3306.sock \
-DSYSCONFDIR=/etc \
-DWITH_INNOBASE_STORAGE_ENGINE=1 \
-DENABLED_LOCAL_INFILE=1 \
-DMYSQL_TCP_PORT=3306 \
-DEXTRA_CHARSETS=all \
-DDEFAULT_CHARSET=utf8mb4 \
-DDEFAULT_COLLATION=utf8mb4_general_ci \
-DWITH_DEBUG=0 \
-DWITH_BOOST=/data/src/boost_1_59_0
make && make install

make clean

\cp support-files/mysql.server /etc/init.d/mysqld
chmod +x /etc/init.d/mysqld
chkconfig --add mysqld
chkconfig mysqld on

ln -s /data/local/mysql /usr/local/mysql
ln -s /data/local/mysql/bin/mysql /usr/local/sbin/mysql
chown -R mysql:mysql /data/mysqldb

echo "Mysql安装完毕"

echo "初始化mysql数据 请执行 /data/local/mysql/bin/mysqld --initialize --user=mysql --basedir=/data/local/mysql --datadir=/data/mysqldb/3306"
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

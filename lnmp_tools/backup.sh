#!/bin/bash

# 使用MySQL5.7 以后的 mysqlpump 方式  利用多线程导出并压缩数据。

USER="backup"
PASSWORD="123456"
DATABASE="test"
BACKUP_DIR=/data/backup/mysql-data/

DATE=`date +%Y%m%d_%H_%M`
DUMPFILE=$DATE.sql
ARCHIVE=$DATE.sql.lz4
LOG="backup.log"
BACKLOGFILE=$BACKUP_DIR$LOG
CMD="/usr/local/mysql/bin/mysqlpump -h127.0.0.1 -u$USER -p$PASSWORD"
OPTIONS="$CMD -S /data/mysqldb/run/mysql3306.sock --compress-output=LZ4 --default-parallelism=6 --databases $DATABASE "

cd $BACKUP_DIR
touch $BACKLOGFILE && echo '' > $BACKLOGFILE
Backup(){
   $OPTIONS > $BACKUP_DIR$ARCHIVE
}

Backup >> $BACKLOGFILE

# 删除 7天以前的 备份压缩文件
find $BACKUP_DIR -mtime +7 -name "*.lz4" -exec rm -rf {} \;

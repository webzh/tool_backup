#!/bin/bash

# https://help.aliyun.com/zh/rds/apsaradb-rds-for-mysql/restore-the-data-of-an-apsaradb-rds-for-mysql-instance-from-a-physical-backup-file-to-a-self-managed-mysql-database
# https://cloud.tencent.com/document/product/236/33363

# https://docs.percona.com/percona-xtrabackup/8.0/yum-repo.html
echo "安装xtrabackup-8.0"
sudo yum install -y https://repo.percona.com/yum/percona-release-latest.noarch.rpm

sudo percona-release enable-only tools release

sudo yum install -y lz4 zstd

echo "安装 qpress"
cd /data/src/
wget https://docs-tencentdb-1256569818.cos.ap-guangzhou.myqcloud.com/qpress-11-linux-x64.tar
# wget https://help-static-aliyun-doc.aliyuncs.com/file-manage-files/zh-CN/20230406/flxd/qpress-11-linux-x64.tar
tar -xf qpress-11-linux-x64.tar -C /usr/local/bin
source /etc/profile
chmod 755 /usr/local/bin/qpress
which qpress


# 1. xbstream -x  -C /data/xxx/ < /data/xxx.xb
# 2. xtrabackup --decompress --target-dir=/data/xxx/
# 3.v1 xtrabackup --defaults-file=/var/mysql_bkdata/backup-my.cnf  --prepare --target-dir=/data/xxx/
# 3.v2 xtrabackup --prepare  --target-dir=/data/xxx/
# 修改backup-my.cnf see to url: https://cloud.tencent.com/document/product/236/33363


# 恢复方式 1
# 1.1 https://docs.percona.com/percona-xtrabackup/8.0/restore-a-backup.html
# 1.2 xtrabackup --copy-back --target-dir=/data/backups/
# 1.3 sudo xtrabackup --defaults-file=/etc/my.cnf --copy-back --target-dir=/var/mysql_bkdata/

# 恢复方式 2
# 2.1 https://cloud.tencent.com/document/product/236/33363
# 2.2 mysqld_safe --defaults-file=/data/mysql/backup-my.cnf --user=mysql --datadir=/data/mysql &

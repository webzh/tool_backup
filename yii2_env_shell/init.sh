#!/bin/bash

echo "系统更新"
yum clean all
yum -y update

echo "关闭Selinux"
sed -i 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/selinux/config
setenforce 0

echo "系统时间设置"
yum install -y ntp
timedatectl set-timezone Asia/Shanghai
timedatectl set-local-rtc 0
timedatectl set-ntp yes
timedatectl status

yum -y install rdate ntpdate

echo  "*/10 * * * * ntpdate ntp1.aliyun.com >> /dev/null" >> /var/spool/cron/root


echo "目录建立"

mkdir -p /data/backup
mkdir -p /data/src
mkdir -p /data/htdocs
mkdir -p /data/local
mkdir -p /data/mysqldb
mkdir -p /data/logs
mkdir -p /data/logs/nginx
mkdir -p /data/logs/php
mkdir -p /data/nginx_cache/proxy_temp_dir
mkdir -p /data/shell
mkdir -p /data/shell/install

echo "安装依赖包"

# 会安装 日志切割 软件 logrotate 以及 监控 monit
yum -y install lrzsz gcc-c++ vim wget zlib-devel openssl-devel ncurses-devel bison curl curl-devel libxml2-devel gd gd-devel gmp-devel libjpeg libpng freetype libjpeg-devel libpng-devel freetype-devel  libmcrypt libmcrypt-dev unzip zip pcre pcre-devel zlib* openssl-devel lua* GeoIP* telnet telnet-server logrotate monit

# ffmpeg
yum -y install epel-release
rpm -v --import http://li.nux.ro/download/nux/RPM-GPG-KEY-nux.ro
rpm -Uvh http://li.nux.ro/download/nux/dextop/el7/x86_64/nux-dextop-release-0-5.el7.nux.noarch.rpm
yum -y install ffmpeg ffmpeg-devel

echo '* soft nofile 65535'>>/etc/security/limits.conf
echo '* hard nofile 65535'>>/etc/security/limits.conf

echo  "系统参数优化 /etc/sysctl.conf"
echo 'net.ipv4.tcp_fin_timeout = 30'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_tw_reuse = 1'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_tw_recycle = 1'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_syncookies = 1'>>/etc/sysctl.conf
echo 'net.ipv4.ip_local_port_range = 10024 62535'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_max_tw_buckets = 6000'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_keepalive_time = 600'>>/etc/sysctl.conf
echo 'net.ipv4.tcp_max_syn_backlog = 8192'>>/etc/sysctl.conf

sysctl -p

currentPath=$(dirname $(readlink -f $0))

echo "移动安装脚本及软件包到/data/src目录下"
cp -rp $currentPath/* /data/src/
chmod +x /data/src/*.sh
cp -rp /data/src/packages/* /data/src/

echo "完毕，请分别执行各个软件的安装脚本"

# 实现VMware虚拟机共享，以下方式仅针对Centos7系统  其他系统见  Google搜索 Centos6 安装vmware tools
# yum -y install kernel-devel-$(uname -r)
# yum -y install open-vm-tools
# /mnt/hgfs/

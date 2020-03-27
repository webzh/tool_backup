#!/bin/bash

echo "安装nginx"
groupadd www && useradd -g www -s /sbin/nologin www
chown -R www:www /data/logs/nginx
cd /data/src
#git clone https://github.com/openresty/echo-nginx-module.git
wget http://nginx.org/download/nginx-1.17.7.tar.gz
tar zxvf nginx-1.17.7.tar.gz
cd /data/src/nginx-1.17.7
./configure \
--prefix=/data/local/nginx \
--with-http_ssl_module \
--with-ipv6 \
--with-pcre \
--with-zlib= \
--with-openssl= \
--with-http_gzip_static_module \
--with-file-aio \
--with-http_stub_status_module \
--with-http_sub_module \
--with-http_realip_module \
--with-http_v2_module
make && make install

echo "设置Nginx软链接"
ln -s /data/local/nginx /usr/local/nginx

echo "复制service启动脚本"
cp /data/src/nginx /etc/init.d/

chkconfig --add nginx
chkconfig nginx on
service nginx start

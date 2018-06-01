#!/bin/bash

echo "安装nginx"
groupadd www && useradd -g www -s /sbin/nologin www
chown -R www:www /data/logs/nginx
cd /data/src
#git clone https://github.com/openresty/echo-nginx-module.git
tar zxvf tengine-2.2.2.tar.gz
cd /data/src/tengine-2.2.2
./configure \
--prefix=/data/local/nginx \
--with-http_ssl_module \
--with-pcre \
--with-zlib= \
--with-openssl= \
--with-http_gzip_static_module \
--with-file-aio \
--with-http_concat_module \
--with-http_footer_filter_module=shared \
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

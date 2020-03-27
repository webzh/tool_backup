#!/bin/bash

echo "安装PHP和Redis"

cd /data/src
yum -y install libevent libevent-devel bzip2 bzip2-devel libmcrypt libxml2 libxml2-devel libjpeg-devel libpng-devel freetype-devel openldap openldap-devel openjpeg-devel libxslt-devel icu libicu libicu-devel libargon2 libargon2-devel

echo "安装PHP包"
cd /data/src
tar zxvf php-7.1.21.tar.gz
cd php-7.1.21
./configure --prefix=/data/local/php \
--with-config-file-path=/data/local/php/etc \
--enable-mysqlnd \
--enable-fpm \
--enable-opcache \
--with-mysqli=mysqlnd \
--with-pdo-mysql=mysqlnd \
--with-openssl \
--with-xsl \
--with-curl \
--with-gettext \
--with-iconv-dir \
--with-kerberos \
--with-libdir=/lib64 \
--with-password-argon2 \
--enable-shmop \
--with-ldap \
--enable-libxml \
--enable-xml \
--enable-mbstring \
--enable-intl \
--with-curl \
--with-gmp \
--enable-soap \
--enable-inline-optimization \
--with-bz2  \
--with-zlib \
--enable-sockets \
--with-sodium \
--enable-sysvsem \
--enable-sysvshm \
--enable-sysvmsg \
--enable-pcntl \
--enable-mbregex \
--with-mhash \
--enable-bcmath \
--enable-zip \
--with-pcre-regex \
--with-gd  \
--with-jpeg-dir \
--with-png-dir \
--with-freetype-dir

make && make install

echo "指定PHP软连接"
ln -s /data/local/php /usr/local/php
ln -s /data/local/php/bin/php /usr/local/sbin/php

echo "复制配置文件"
cp /data/src/php-7.1.21/php.ini-production /data/local/php/etc/php.ini
cp -rp /data/local/php/etc/php-fpm.conf.default /data/local/php/etc/php-fpm.conf
cp /data/local/php/etc/php-fpm.d/www.conf.default /data/local/php/etc/php-fpm.d/www.conf
\cp -r /data/src/php-7.1.21/sapi/fpm/init.d.php-fpm /etc/init.d/php-fpm
chmod +x /etc/init.d/php-fpm

echo "Install PHP-redis扩展"
cd /data/src
yum -y install autoconf
wget http://pecl.php.net/get/redis-5.0.2.tgz
tar zxvf redis-5.0.2.tgz
cd redis-5.0.2 && /usr/local/php/bin/phpize && ./configure --with-php-config=/usr/local/php/bin/php-config && make && make install

echo "安装ImageMagick扩展"
yum -y install ImageMagick ImageMagick-devel
cd /data/src/
wget http://pecl.php.net/get/imagick-3.4.4.tgz
tar zxvf imagick-3.4.4.tgz
cd imagick-3.4.4
/usr/local/php/bin/phpize
./configure --with-php-config=/usr/local/php/bin/php-config --with-imagick
make && make install

cd /data/src
echo "修改php.ini文件"
sed -i '/;extension=php_xsl.dll/aextension=redis.so\nextension=imagick.so\n\nzend_extension=opcache.so\nopcache.enable=1\nopcache.enable_cli=1' /usr/local/php/etc/php.ini
sed -i 's/expose_php = On/expose_php = Off/g' /usr/local/php/etc/php.ini
sed -i 's/;date.timezone =/date.timezone = Asia\/Shanghai/g' /usr/local/php/etc/php.ini
sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /usr/local/php/etc/php.ini

chkconfig --add php-fpm
chkconfig php-fpm on
service php-fpm start

echo "安装composer"
cd /data/src
curl -sS https://getcomposer.org/installer | php
mv composer.phar /usr/local/bin/composer

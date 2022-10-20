#!/bin/bash


mkdir -p /usr/share/fonts/chinese

cp -rp ./fonts/* /usr/share/fonts/chinese/

chmod -R 755 /usr/share/fonts/chinese/


# copy <dir>/usr/share/fonts/chinese</dir>  to fonts.conf
vim /etc/fonts/fonts.conf


fc-cache

fc-list

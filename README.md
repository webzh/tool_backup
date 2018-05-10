## tool_backup/shdowsocks ##
Google bbr 加速安装脚本 感谢秋水逸冰大神提供 https://teddysun.com/489.html

Shadowsocks 一键安装脚本（四合一）感谢秋水逸冰大神提供 https://teddysun.com/486.html

## tool_backup/yii2_env_shell ##
### Yii2 PHP环境安装 ###
#### 以下均为CentOS7系统下执行 ####
##### 初始化 #####
```shell
# 注意路径opt修改为自己的
cd /opt/tool_backup/yii2_env_shell && ./init.sh
```
##### 安装 MySQL-5.7.22 #####
```shell
cd /data/src/ && ./mysql.sh
# 安装完毕，需要初始化数据库
# 启动停止脚本
service mysqld start|stop|restart
```
##### 安装 Nginx For Tengine-2.2.2 #####
```shell
cd /data/src/ && ./nginx.sh
# 启动停止脚本
service nginx start|stop|restart
```
##### 安装 redis-3.2.11 #####
```shell
cd /data/src/ && ./redis.sh
# 启动停止脚本
service redis start|stop|restart
```
##### 安装PHP-7.2.5 #####
```shell
cd /data/src/ && ./php.sh
# 启动停止脚本
service php-fpm start|stop|restart
```

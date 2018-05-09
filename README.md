# tool_backup/shdowsocks
Google bbr 加速安装脚本 感谢秋水逸冰大神提供 https://teddysun.com/489.html

Shadowsocks 一键安装脚本（四合一）感谢秋水逸冰大神提供 https://teddysun.com/486.html

# tool_backup/yii2_env_shell
## Yii2 PHP环境安装 ##
##### 初始化 #####
cd /opt/tool_backup/yii2_env_shell
./init.sh

##### 安装 MySQL-5.7.22 #####
cd /data/src/ && ./mysql.sh

##### 安装 Nginx For Tengine-2.2.2 #####
cd /data/src/ && ./nginx.sh

##### 安装 redis-3.2.11 #####
cd /data/src/ && ./redis.sh

##### 安装PHP-7.2.5 #####
cd /data/src/ && ./php.sh

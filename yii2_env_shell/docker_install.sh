#!/bin/bash

yum remove docker \
                  docker-client \
                  docker-client-latest \
                  docker-common \
                  docker-latest \
                  docker-latest-logrotate \
                  docker-logrotate \
                  docker-selinux \
                  docker-engine-selinux \
                  docker-engine

# 注意镜像源地址更换
yum-config-manager \
     --add-repo \
     https://download.docker.com/linux/centos/docker-ce.repo


# 编辑profile，
vi /etc/profile
# 在上面增加下面内容
JAVA_HOME=/usr/java/jdk1.8.0_191
JRE_HOME=$JAVA_HOME/jre
PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar:$JRE_HOME/lib
export JAVA_HOME JRE_HOME PATH CLASSPATH

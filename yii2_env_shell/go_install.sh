#!/bin/bash

echo "golang  安装部署"

cd /data/src/
wget https://golang.google.cn/dl/go1.18.6.linux-amd64.tar.gz
tar zxvf go1.18.6.linux-amd64.tar.gz -C /usr/lib/

# 环境变量
#export GOROOT=/usr/lib/go
#export GOPATH=/data/htdocs/goproject
#export PATH=$PATH:$GOROOT/bin

echo -e >> /etc/profile
echo '#Go Env Set'>>/etc/profile
echo 'export GOPROXY=https://goproxy.cn'>>/etc/profile
echo 'export GOROOT=/usr/lib/go'>>/etc/profile
echo 'export GOPATH=/data/htdocs/goproject'>>/etc/profile
echo 'export PATH=$PATH:$GOROOT/bin'>>/etc/profile
echo 'export GO111MODULE=on'>>/etc/profile


# service  demo
[Unit]
Description=ExampleService
After=network-online.target
[Service]
Type=simple
User=www
Group=www
ExecStart=xxxx -c xxx.conf
ExecReload=/bin/kill -s HUP $MAINPID
ExecStop=/bin/kill -s QUIT $MAINPID
KillMode=process
Restart=on-failure
RestartSec=20
ExecStopPost=xxx.sh ExampleService
StandardOutput=syslog+console
StandardError=inherit
SyslogIdentifier=ExampleService
[Install]
WantedBy=multi-user.target







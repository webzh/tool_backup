#!/bin/bash

echo "升级默认git版本"
cd /data/src

yum remove git
yum remove git-*

wget http://opensource.wandisco.com/centos/7/git/x86_64/git-2.41.0-1.WANdisco.x86_64.rpm
yum localinstall git-2.41.0-1.WANdisco.x86_64.rpm


curl -L "https://packages.gitlab.com/install/repositories/runner/gitlab-runner/script.rpm.sh" | sudo bash

echo "列出各个版本的gitlab runner"
yum list gitlab-runner --showduplicates | sort -r

echo "安装指定版本的gitlab-runner"

sudo -E yum install -y gitlab-runner-15.3.0-1

#sudo yum install gitlab-runner

#ExecStart=/usr/bin/gitlab-runner "run" "--working-directory" "/data/gitlab-builds" "--config" "/etc/gitlab-runner/config.toml" "--service" "gitlab-runner" "--user" "root"
#!/bin/bash


HOST="gitlab.xxxx.com"

sudo yum install -y curl policycoreutils-python openssh-server openssh-clients
sudo systemctl enable sshd
sudo systemctl start sshd
sudo firewall-cmd --permanent --add-service=http
sudo firewall-cmd --permanent --zone=public --add-port=80/tcp
sudo firewall-cmd --permanent --add-service=https
sudo firewall-cmd --permanent --zone=public --add-port=443/tcp
sudo systemctl reload firewalld
sudo yum install -y postfix
sudo systemctl enable postfix
sudo systemctl start postfix
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ce/script.rpm.sh | sudo bash
EXTERNAL_URL="https://${HOST}" yum install -y gitlab-ce-12.0.8-ce.0.el7.x86_64

# 汉化步骤
<<COMMENT
cd /tmp/
gitlab_version=$(sudo cat /opt/gitlab/embedded/service/gitlab-rails/VERSION)

yum -y install git
git clone https://gitlab.com/xhang/gitlab.git
cd gitlab/
git fetch
git diff v${gitlab_version} v${gitlab_version}-zh > ../${gitlab_version}-zh.diff
cd ..
gitlab-ctl stop
yum install -y patch
patch -d /opt/gitlab/embedded/service/gitlab-rails -p1 < 12.0.8-zh.diff
gitlab-ctl start
COMMENT
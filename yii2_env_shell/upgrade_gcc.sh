#!/bin/bash

# 升级gcc g++
yum install -y centos-release-scl
yum install -y devtoolset-8-gcc*
scl enable devtoolset-8 bash
source /opt/rh/devtoolset-8/enable
gcc --version
g++ --version
mv /usr/bin/gcc /usr/bin/gcc-4.8.5
ln -s /opt/rh/devtoolset-8/root/bin/gcc /usr/bin/gcc
mv /usr/bin/g++ /usr/bin/g++-4.8.5
ln -s /opt/rh/devtoolset-8/root/bin/g++ /usr/bin/g++
gcc --version
g++ --version
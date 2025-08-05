#!/bin/bash

# 备份原始的 sources.list 文件
cp /etc/apt/sources.list /etc/apt/sources.list.bak

# 写入阿里云的 Ubuntu 镜像源到 sources.list 文件
cat << EOF > /etc/apt/sources.list
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-updates main restricted universe multiverse
deb http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
# deb-src http://mirrors.tuna.tsinghua.edu.cn/ubuntu/ noble-backports main restricted universe multiverse
EOF

echo "sources.list 文件替换完成"

# 更新软件包列表
apt update

# 安装编译工具和 Git
sudo apt install build-essential
sudo apt install git

echo "镜像源更新完成"

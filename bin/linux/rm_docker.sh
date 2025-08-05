#!/bin/bash

echo "警告：此脚本将卸载 Docker 并可能删除所有 Docker 镜像、容器和卷。"
read -p "你确定要继续吗？ (yes/no): " confirmation

if [[ "$confirmation" != "yes" ]]; then
    echo "卸载已取消。"
    exit 0
fi

echo "正在停止 Docker 服务..."
sudo systemctl stop docker.socket
sudo systemctl stop docker

echo "正在卸载 Docker Engine, CLI, Containerd 和相关插件..."
sudo apt-get purge -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo apt-get autoremove -y --purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-ce-rootless-extras

echo "正在删除 Docker 相关的配置文件和目录..."
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
sudo rm -rf /etc/docker
sudo rm -rf /etc/apt/keyrings/docker.gpg
sudo rm -f /etc/apt/sources.list.d/docker.list

echo "正在更新 apt 包列表..."
sudo apt-get update

echo "正在清理不再需要的包..."
sudo apt-get autoremove -y

echo "Docker 卸载完成。"
echo "请注意：一些手动安装的 Docker 相关工具或配置文件可能仍需要手动删除。"
echo "如果你之前将用户添加到了 'docker' 组，你可能需要手动将其从中移除，例如：sudo gpasswd -d \$USER docker"

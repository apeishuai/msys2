#!/bin/bash

# Docker 一键安装脚本 (Ubuntu/Debian) - 终极修复版
set -e

echo "🐳 开始安装 Docker..."

# 1. 清理旧版本
echo "🧹 清理旧版本 Docker..."
sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

# 2. 安装依赖
echo "📦 安装依赖工具..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg lsb-release

# 3. 强制创建密钥目录（修复权限问题）
echo "🔑 强制更新 Docker GPG 密钥..."
sudo mkdir -p /etc/apt/keyrings
sudo rm -f /etc/apt/keyrings/docker.gpg  # 强制删除旧密钥
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo gpg --batch --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# 4. 确保sources.list.d目录存在
echo "📮 添加 Docker APT 仓库..."
sudo mkdir -p /etc/apt/sources.list.d
sudo rm -f /etc/apt/sources.list.d/docker.list  # 清除旧配置

REPO_STRING="deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
echo "$REPO_STRING" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# 5. 安装 Docker
echo "🚀 安装 Docker Engine..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 6. 验证安装
echo "✅ 验证 Docker..."
sudo docker run --rm hello-world

# 7. 配置用户组
echo "🛠️ 配置当前用户免 sudo..."
sudo usermod -aG docker $USER
newgrp docker <<EOF
echo "🌟 Docker 已安装成功！"
docker --version
EOF

# 8. 配置镜像加速
echo "🚄 配置国内镜像加速..."
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<-'EOF'
{
  "registry-mirrors": [
    "https://registry.docker-cn.com",
    "https://mirror.baidubce.com"
  ],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
sudo systemctl restart docker

echo "🎉 Docker 安装完成！版本信息："
docker --version

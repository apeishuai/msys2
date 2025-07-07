#!/bin/bash
# 安全卸载 v2rayA 脚本
echo "🔹 开始安全卸载 v2rayA..."

# 1. 关闭代理
echo "🛑 停止 v2rayA 服务..."
sudo systemctl stop v2raya
sleep 2

# 2. 检查是否停止
if systemctl is-active --quiet v2raya; then
    echo "⚠️ 服务停止失败，强制终止..."
    sudo pkill -9 v2raya
fi

# 3. 卸载
echo "🧹 卸载 v2rayA..."
[ -f /usr/local/bin/v2raya ] && sudo /usr/local/bin/v2raya --remove

# 4. 清理残留
echo "♻️ 清理残留文件..."
sudo rm -rf /etc/v2raya /var/lib/v2raya

echo "✅ v2rayA 已安全卸载"


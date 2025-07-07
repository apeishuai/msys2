#!/bin/bash

# 脚本名称: analyze_network.sh
# 描述: 分析 Windows 进程的网络连接情况 (MSYS2 环境)
# 需要: MSYS2 环境安装 netstat, awk, grep, tasklist 等工具

# 检查是否在 MSYS2 环境中运行
if [[ ! $(uname -s) == *"MSYS"* ]]; then
    echo "错误: 此脚本需要在 MSYS2 环境中运行"
    exit 1
fi

# 检查是否以管理员权限运行
admin_check() {
    net session >/dev/null 2>&1
    if [ $? -ne 0 ]; then
        echo "警告: 建议使用管理员权限运行此脚本以获取完整信息"
        read -p "是否继续? (y/n) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            exit 1
        fi
    fi
}

# 获取网络连接信息
get_network_info() {
    echo -e "\n正在收集网络连接信息..."
    echo -e "\n活动 TCP 连接:"
    netstat -ano -p tcp | grep -E "LISTENING|ESTABLISHED"
    
    echo -e "\n活动 UDP 连接:"
    netstat -ano -p udp
    
    echo -e "\n进程列表摘要:"
    tasklist | head -n 5
}

# 生成详细报告
generate_report() {
    echo -e "\n生成详细网络连接报告..."
    
    # 创建临时文件
    tmp_netstat=$(mktemp)
    tmp_tasklist=$(mktemp)
    
    # 收集数据
    netstat -ano -p tcp > "$tmp_netstat"
    netstat -ano -p udp >> "$tmp_netstat"
    tasklist /FO CSV /NH > "$tmp_tasklist"
    
    # 处理数据
    echo -e "\n详细的进程网络连接信息:"
    echo "------------------------------------------------------------"
    echo "协议  本地地址          外部地址          状态       PID  进程名"
    echo "------------------------------------------------------------"
    
    grep -E "TCP|UDP" "$tmp_netstat" | while read -r line; do
        # 提取协议
        proto=$(echo "$line" | awk '{print $1}')
        
        # 提取本地地址
        local_addr=$(echo "$line" | awk '{print $2}')
        
        # 提取外部地址 (TCP)
        if [ "$proto" == "TCP" ]; then
            remote_addr=$(echo "$line" | awk '{print $3}')
            state=$(echo "$line" | awk '{print $4}')
        else
            remote_addr="*:*"
            state=""
        fi
        
        # 提取PID
        pid=$(echo "$line" | awk '{print $NF}')
        
        # 查找进程名
        process_name=$(grep "\"$pid\"" "$tmp_tasklist" | awk -F'","' '{print $1}' | tr -d '"')
        [ -z "$process_name" ] && process_name="未知进程"
        
        # 输出格式化信息
        printf "%-5s %-16s %-16s %-10s %-6s %s\n" "$proto" "$local_addr" "$remote_addr" "$state" "$pid" "$process_name"
    done
    
    # 清理临时文件
    rm -f "$tmp_netstat" "$tmp_tasklist"
}

# 主函数
main() {
    echo "Windows 进程网络分析工具 (MSYS2)"
    echo "--------------------------------"
    
    admin_check
    get_network_info
    generate_report
    
    echo -e "\n分析完成。"
}

# 执行主函数
main

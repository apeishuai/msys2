#!/bin/bash

CPU_THRESHOLD=70

PID=$(ps -eo pid,%cpu --sort=-%cpu | head -n 2 | tail -n 1 | awk '{print $1}')
CPU_USAGE=$(ps -eo pid,%cpu --sort=-%cpu | head -n 2 | tail -n 1 | awk '{print $2}')

# 检查 CPU 使用率是否超过阈值
if (( $(echo "$CPU_USAGE > $CPU_THRESHOLD" | bc -l) )); then
    echo "进程 $PID 的 CPU 使用率达到了 $CPU_USAGE%，超过了阈值 $CPU_THRESHOLD%，将被终止。"
    kill -9 $PID
else
    echo "当前没有进程的 CPU 使用率超过阈值 $CPU_THRESHOLD%。"
fi

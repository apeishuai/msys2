#!/bin/bash

THRESHOLD=80 # 设置内存使用阈值（百分比）
while true; do
  MEMORY_USAGE=$(free | awk '/Mem/{printf("%.2f"), $3/$2*100}')
  if (( $(echo "$MEMORY_USAGE > $THRESHOLD" | bc -l) )); then
	curl "https://api.day.app/s3riAtsGpyiJh8zrrsjvRn/$(echo "Memory usage is above $THRESHOLD%: $MEMORY_USAGE%")"
  fi
  sleep 60 # 每分钟检查一次
done

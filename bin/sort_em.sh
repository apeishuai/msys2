# 索引em，并排序；辅助电气编程-脚本


#!/bin/bash

# 从管道或文件读取数据，提取 cm[0-9]+ 模式并换行输出
# 用法示例:
#   cat your_file.txt | ./extract_em.sh
#   ./extract_em.sh < your_file.txt

if [ -t 0 ]; then
  echo "错误: 请通过管道传递输入数据"
  echo "示例: cat your_file.txt | $0"
  exit 1
fi

awk '{
  while(match($0, /cm[0-9]+/)) {
    print substr($0, RSTART, RLENGTH)
    $0 = substr($0, RSTART+RLENGTH)
  }
}' | sort -u  # 去重并排序

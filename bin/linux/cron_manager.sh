#!/bin/bash

# 定时任务管理脚本

CRONTAB_FILE="/tmp/crontab_manage_$$"

# 显示帮助信息
show_help() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -a <script> <schedule>  Add a script to crontab"
    echo "                         Example: -a /home/user/backup.sh \"0 3 * * *\""
    echo "  -l                      List all cron jobs"
    echo "  -d <script>             Delete all cron jobs for a specific script"
    echo "  -h                      Show this help message"
    echo ""
    echo "Schedule format:"
    echo "  * * * * * command_to_execute"
    echo "  | | | | |"
    echo "  | | | | ----- Day of week (0 - 7) (Sunday=0 or 7)"
    echo "  | | | ------- Month (1 - 12)"
    echo "  | | --------- Day of month (1 - 31)"
    echo "  | ----------- Hour (0 - 23)"
    echo "  ------------- Minute (0 - 59)"
}

# 添加定时任务
add_cron_job() {
    local script=$1
    local schedule=$2
    
    if [ ! -f "$script" ]; then
        echo "Error: Script file $script does not exist!"
        exit 1
    fi
    
    if ! [[ "$schedule" =~ ^[0-9*]+[[:space:]]+[0-9*]+[[:space:]]+[0-9*]+[[:space:]]+[0-9*]+[[:space:]]+[0-9*]+$ ]]; then
        echo "Error: Invalid cron schedule format!"
        show_help
        exit 1
    fi
    
    chmod +x "$script"
    
    (crontab -l 2>/dev/null; echo "$schedule $script") | crontab -
    echo "Added cron job:"
    echo "$schedule $script"
}

list_cron_jobs() {
    echo "Current cron jobs:"
    echo "-----------------"
    crontab -l 2>/dev/null || echo "No cron jobs found"
}

delete_cron_jobs() {
    local script=$1
    
    if [ ! -f "$script" ]; then
        echo "Warning: Script file $script does not exist, but will check cron jobs anyway..."
    fi
    
    crontab -l 2>/dev/null > "$CRONTAB_FILE"
    
    if ! grep -q "$script" "$CRONTAB_FILE"; then
        echo "No cron jobs found for script: $script"
        rm -f "$CRONTAB_FILE"
        return
    fi
    
    grep -v "$script" "$CRONTAB_FILE" | crontab -
    rm -f "$CRONTAB_FILE"
    
    echo "Removed all cron jobs for: $script"
}

cleanup() {
    if [ -f "$CRONTAB_FILE" ]; then
        rm -f "$CRONTAB_FILE"
    fi
}

trap cleanup EXIT

while getopts "a:d:lh" opt; do
    case $opt in
        a)
            if [ $# -lt 3 ]; then
                echo "Error: Missing arguments for -a option"
                show_help
                exit 1
            fi
            script=$2
            schedule=$3
            add_cron_job "$script" "$schedule"
            exit 0
            ;;
        l)
            list_cron_jobs
            exit 0
            ;;
        d)
            if [ -z "$2" ]; then
                echo "Error: Missing script path for -d option"
                show_help
                exit 1
            fi
            delete_cron_jobs "$2"
            exit 0
            ;;
        h)
            show_help
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG"
            show_help
            exit 1
            ;;
    esac
done

if [ $OPTIND -eq 1 ]; then
    show_help
    exit 0
fi

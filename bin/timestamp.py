import datetime
import subprocess

def generate_custom_timestamp():
    """
    生成指定格式的时间戳：<YYYY-MM-DD Day HH:MM>
    """
    current_time = datetime.datetime.now()
    date_part = current_time.strftime("%Y-%m-%d")
    day_part = current_time.strftime("%a")
    time_part = current_time.strftime("%H:%M")
    formatted_timestamp = f"<{date_part} {day_part} {time_part}>"
    return formatted_timestamp

def copy_to_clipboard(text):
    """
    将文本复制到Windows剪贴板
    """
    try:
        # 调用Windows的clip.exe工具
        subprocess.run(["clip.exe"], input=text.encode("utf-8"), check=True)
        print(f"已将时间戳复制到剪贴板：{text}")
    except Exception as e:
        print(f"复制到剪贴板时出错：{e}")

if __name__ == "__main__":
    timestamp = generate_custom_timestamp()
    copy_to_clipboard(timestamp)

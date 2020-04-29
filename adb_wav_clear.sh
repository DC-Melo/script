adb root
adb remount
adb shell ls /sdcard/tencent/wecarspeech/data/dingdang/
echo -n "ctrl+c 终止清除..."
read any_key
adb shell rm  -rf /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav/*
echo -n "完成删除,任意键退出..."
read any_key

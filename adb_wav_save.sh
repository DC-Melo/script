adb shell ls /sdcard/tencent/wecarspeech/data/dingdang/
echo -n "ctrl+c 终止开始录音..."
read any_key

adb shell mv /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav_$(date +%Y-%m-%d_%H-%M-%S)
adb shell touch  /sdcard/tencent/wecarspeech/data/dingdang/debug_save_wav.conf
adb shell am force-stop com.tencent.wecarspeech
adb shell ls /sdcard/tencent/wecarspeech/data/dingdang/
echo -n "已经为你重启wecarspeech,已经开始录音,任意键退出..."
read any_key

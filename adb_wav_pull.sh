adb shell ls /sdcard/tencent/wecarspeech/data/dingdang/
echo -n "ctrl+c 终止取tmp_wave..."
read any_key
adb shell rm  /sdcard/tencent/wecarspeech/data/dingdang/debug_save_wav.conf
adb shell am force-stop com.tencent.wecarspeech
save_wav_folder="tmp_wav_"$(date +%Y-%m-%d_%H-%M-%S)
adb pull /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav $save_wav_folder
adb shell mv /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav /sdcard/tencent/wecarspeech/data/dingdang/$save_wav_folder
adb shell ls /sdcard/tencent/wecarspeech/data/dingdang/
echo -n "任意键退出..."
read any_key

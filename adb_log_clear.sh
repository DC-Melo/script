#!/bin/bash
adb root
adb remount
echo "clear wecarnavi"
adb shell rm -rf /sdcard/tencent/wecarnavi/log/*
echo "clear wecarspeech"
adb shell rm -rf /sdcard/tencent/wecarspeech/log/*
echo "clear logger"
adb shell rm -rf  /data/logger/*
echo "clear tombstones"
adb shell rm -rf  /data/tombstones/*
echo "clear anr"
adb shell rm -rf /data/anr/*
echo "clear log finished."
adb logcat -c



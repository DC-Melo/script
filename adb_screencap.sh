#!/bin/sh
png_name=`date +%Y%-m-%d_%H-%M-%S`.png
adb root
adb remount
adb  shell screencap -p | sed "s/^M$//" > $png_name
png_name=`date +%Y%-m-%d_%H-%M-%S`.png
adb shell /system/bin/screencap -p /sdcard/$png_name
adb pull /sdcard/$png_name ./

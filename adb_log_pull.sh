#!/bin/bash
echo '
-------------------------------------------------------------------------
| Time	: 2019-07-04
| Author: Melo.DC
| Email	: melo.dachar@gmail.com
| File	: adb_pull_log_video.sh
| Param.: [log name], [number of picture video]
| Exam.	: adb_pull_log_video.sh 0000wt 1
------------------------------------------------------------------------'
log_folder=$(date +%Y-%m-%d_%H-%M-%S)"_log"
mkdir -p $log_folder
adb pull /sdcard/tencent/wecarnavi/log ./$log_folder/wecarnavi/
adb pull /sdcard/tencent/wecarspeech/log ./$log_folder/wecarspeech/
adb pull /data/logger ./$log_folder/logger/
adb pull /data/tombstones ./$log_folder/tombstones/
adb pull /data/anr ./$log_folder/anr/
adb pull /sdcard/record.wav ./$log_folder/
adb pull /sdcard/tencent/wecarspeech/data/dingdang/tmp_wav ./$log_folder/

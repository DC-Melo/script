#!/bin/sh
logname=`date +%Y%m%d_%H%M%S`.log
adb  logcat   -v  threadtime   -b   events  -b  main  -b  system >> logcat_$logname

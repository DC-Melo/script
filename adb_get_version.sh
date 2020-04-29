#!/bin/bash
echo '
-------------------------------------------------------------------------
| Time	: 2019-07-04
| Author: Melo.DC
| Email	: melo.dachar@gmail.com
| File	: adb_get_version.sh
| Func. : get android os and apk version.
| Param.: null
| Exam.	: adb_get_version.sh
------------------------------------------------------------------------
'
vehicle_device=`adb devices -l | awk '{if($2=="device"){print $1}}'`
if [ ${#vehicle_device} -gt 0 ];then
    adb -s $vehicle_device root >/dev/null 2>&1
    adb -s $vehicle_device remount >/dev/null 2>&1
    adb shell cat /system/build.prop |grep -i  "ro.build.display.id\|ro.build.date" |tee wt_version.txt
    speechdata_version=`adb shell cat sdcard/tencent/wecarspeech/data/data.version`
    echo 'wecarspeech.data.version='$speechdata_version | tee -a  wt_version.txt
    adb -s $vehicle_device shell dumpsys package |awk '/Package\s\[com.wt.*|Package\s\[com.autopai.*|Package\s\[com.*wutong.*|Package\s\[com.tencent.*|Package\s\[.*launcherWT.*|Package\s\[com.*systemui.*|Package\s\[com.*cityofphantom.*/ \
        {n=1} n>=1&&n<=2 \
        { \
            if(n==1){ \
                n++; \
                print $1,$2 \
            }else if(match($1,/versionName.*/)==1) \
            { \
                n++; \
                print $0 \
            }else{ \
                last; \
            } \
        }' | tee -a wt_version.txt
    echo -e "\n\n\nother infomation as follows" >> wt_version.txt
    echo "===========================" >> wt_version.txt
    adb -s $vehicle_device shell dumpsys package |awk '/Package\ \[com.*/ \
        {n=1} n>=1&&n<=2 \
        { \
            if(n==1){ \
                n++; \
                print $1,$2 \
            }else if(match($1,/versionName.*/)==1) \
            { \
                n++; \
                print $0 \
            }else{ \
                last; \
            } \
        }' >> wt_version.txt
else
    echo "not find vehicle device"
fi



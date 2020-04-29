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
log_folder=`date +%Y-%m-%d_%H-%M-%S`
mkdir $log_folder && cd $_
phone_device=`adb devices -l | awk '{if($1!="123456789" && $2=="device"){print $1}}'`
if [ ${#phone_device} -gt 0 ];then
    echo "pull phone video."
    if [ "$1" -gt 0 ];then #2>/dev/null 
	    for((i=1;i<=$1;i++));  
	    do   
	        last_file=`adb -s $phone_device shell ls /sdcard/DCIM/Camera -t |head -n$i|tail -n1|awk '{print $0}'`
            adb -s $phone_device pull /sdcard/DCIM/Camera/$last_file 
	    done	
    else
        last_file=`adb -s $phone_device shell ls /sdcard/DCIM/Camera -t | head -n1|awk '{print $0}'`
        adb -s $phone_device pull /sdcard/DCIM/Camera/$last_file
        last_file=`adb -s $phone_device shell ls /sdcard/DCIM/Camera -t |head -n2|tail -n1|awk '{print $0}'`
        adb -s $phone_device pull /sdcard/DCIM/Camera/$last_file 
        last_file=`adb -s $phone_device shell ls /sdcard/DCIM/Camera -t |head -n3|tail -n1|awk '{print $0}'`
        adb -s $phone_device pull /sdcard/DCIM/Camera/$last_file 
    fi
    echo "pull video finished."
else
    echo "not find video you record."
fi
vehicle_device=`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'`
if [ ${#vehicle_device} -gt 0 ];then
	if [ $vehicle_device==`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'` ]; then
	    adb -s $vehicle_device root >/dev/null 2>&1
	    adb -s $vehicle_device remount >/dev/null 2>&1
	    adb shell cat /system/build.prop |grep -i  "ro.build.display.id\|ro.build.date" >> device.ver
        speechdata_version=`adb shell cat sdcard/tencent/wecarspeech/data/data.version`
        echo 'wecarspeech.data.version='$speechdata_version >>  device.ver
        adb -s $vehicle_device shell dumpsys package |awk '/Package\s\[com.*/ \
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
        }' >> device.ver

	    echo "pull wecarnavi,about `adb shell du -sm /sdcard/tencent/wecarnavi/log |awk '{print $1}'` M, 2M/s"
	    mkdir log
	    adb -s $vehicle_device pull /sdcard/tencent/wecarnavi/log ./log/wecarnavi/
	else 
	    echo "adb disconced.please reconnect adb"
	fi

	if [ $vehicle_device==`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'` ]; then
	    echo "pull wecarspeech,about `adb shell du -sm //sdcard/tencent/wecarspeech/log |awk '{print $1}'` M,2M/s"
	    adb -s $vehicle_device pull /sdcard/tencent/wecarspeech/log ./log/wecarspeech/
	else 
	    echo "adb disconced.please reconnect adb"
	fi


	if [ $vehicle_device==`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'` ]; then
	    echo "pull logger,about `adb shell du -sm /data/logger |awk '{print $1}'` M, 2M/s"
	    adb -s $vehicle_device pull /data/logger ./log/logger/
	else 
	    echo "adb disconced.please reconnect adb"
	fi


	if [ $vehicle_device==`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'` ]; then
	    echo "pull logger,about `adb shell du -sm /data/tombstones |awk '{print $1}'` M, 2M/s"
	    adb -s $vehicle_device pull /data/tombstones ./log/tombstones/
	else 
	    echo "adb disconced.please reconnect adb"
	fi
	if [ $vehicle_device==`adb devices -l | awk '{if($1=="123456789" && $2=="device"){print $1}}'` ]; then
	    echo "pull logger,about `adb shell du -sm /data/anr |awk '{print $1}'` M, 2M/s"
	    adb -s $vehicle_device pull /data/anr ./log/anr/
	    echo "pull log finished."
	    echo "zip the log, it will last 60s"
	    zip -r -q -s 45m $log_folder"_log.zip" log
	    	    echo "please input bug info:"
	    echo -n  "【测试环境】" |tee -a bug_description.txt 
		read  env 
		echo $env >> bug_description.txt
	    echo -n  "【前提条件】" |tee -a bug_description.txt 
		read  cond 
		echo $cond >> bug_description.txt
		echo -n  "【重现步骤】" |tee -a bug_description.txt 
		read  action 
		echo $action >> bug_description.txt
		echo -n  "【实际结果】" |tee -a bug_description.txt 
		read  act_rusult 
		echo $act_rusult >> bug_description.txt
		echo -n  "【期望结果】" |tee -a bug_description.txt 
		read  expresult 
		echo $expresult >> bug_description.txt
		echo -n  "【复现概率】" |tee -a bug_description.txt 
		read  probability
		echo $probability >> bug_description.txt
		echo -n  "【恢复条件】" |tee -a bug_description.txt 
		read  res_cond
		echo $res_cond >> bug_description.txt
		echo -n  "【发生时间】"$(date +%Y-%m-%d_) |tee -a bug_description.txt 
		read  bug_time 
		echo $bug_time >> bug_description.txt
		echo -n  "【版本信息】" >> bug_description.txt
		awk '/ro.build.display.*|ro.build.date.*|wecarspeech.data.version.*/' device.ver |tee -a bug_description.txt
		awk '/Package\s\[com.*wt.*|Package\s\[com.autopai.*|Package\s\[com.*wutong.*\
		|Package\s\[com.tencent.*|Package\s\[.*launcherWT.*|Package\s\[com.*systemui.*\
		|Package\s\[com.*cityofphantom.*/ \
        {n=1} n>=1&&n<=2 \
        { \
            if(n==1){ \
                n++; \
                print $0 \
            }else if(match($1,/versionName.*/)==1) \
            { \
                n++; \
                print $0 \
            }else{ \
                last; \
            } \
        }' device.ver | tee -a bug_description.txt
        #mv $log_folder"_log.zip" $log_folder"["$env"]"$action"<"$act_rusult">_log.zip"
        mv ../$log_folder ../$log_folder"["$env"]"$action"<"$act_rusult 
	else
	  echo "adb disconced.please reconnect adb"
	fi
            #tar -czvf $log_folder.tar.gz wecarnavi wecarspeech logger tombstones anr
            #days=`date -d "3 days ago" +%Y%m%d`'|'`date -d "2 days ago" +%Y%m%d`'|'`date -d "1 days ago" +%Y%m%d`
            #find wecarnavi wecarspeech logger tombstones anr -regextype posix-extended -not -regex ".*("$days").*" > tar.list
            #tar -T tar.list -czvf $log_folder'_today'.tar.gz 
            #tar -zcvf test.tar.gz anr logger tombstones wecarnavi wecarspeech | split -b 1m -d -a 1 - test.tar.gz.
else
    echo "not find vehicle device"
fi

#!/usr/bin/env bash
if [  -n "$(uname -a | grep -i ubuntu)" ]; then
    dateBegin=$(date --date="19851018" +%s)
elif [  -n "$(uname -a | grep -i centos)" ]; then
    yum update
elif [  -n "$(uname -a | grep -i darwin)" ]; then
    dateBegin=`date -jf %Y%m%d 19851018 +%s`
else
    echo Unknown system
fi
if [ ! -n "$1" ] ;then
    echo "you have not input a word!"
    dateEnd=$(date +%s)
    WeekDay=`date +%V%a%y`
    DateDay=`date +%Y%m%d`
else
    echo "the word you input is $1"
    dateEnd=`date -d $1 +%s`
    WeekDay=`date -d $1 +%V%a%y`
    DateDay=`date -d $1 +%Y%m%d`
fi


LiveDay=$((($dateEnd - $dateBegin)/86400))
RemainingDay=$((12578*2-$LiveDay))

echo Today is: $DateDay $WeekDay, Live days: $LiveDay days,Remaining Days: $RemainingDay days
echo $RemainingDay-$WeekDay-$DateDay
touch $RemainingDay-$WeekDay-$DateDay

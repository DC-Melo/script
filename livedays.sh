#!/bin/bash
WeekDay=`date +%V%a%y`
DateDay=`date +%Y%m%d`
echo $OSTYPE
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo  Do something under GNU/Linux platform
    LiveDay=$((($(date +%s) - $(date --date="19851018" +%s) )/(60*60*24) ))
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo  Do something under Mac OS X platform        
    LiveDay=$(((`date +%s` - `date -jf %Y-%m-%d 1985-10-18 +%s`)/86400))
elif [[ "$OSTYPE" == "cygwin" ]]; then
    echo  POSIX compatibility layer and Linux environment emulation for Windows
elif [[ "$OSTYPE" == "msys" ]]; then
    echo Lightweight shell and GNU utilities compiled for Windows part of MinGW
elif [[ "$OSTYPE" == "win32" ]]; then
    echo win32 Im not sure this can happen.
elif [[ "$OSTYPE" == "freebsd"* ]]; then
    echo freebsd
else
    echo Unknown system
fi
RemainingDay=$((12578*2-$LiveDay))

echo Today is: $DateDay $WeekDay, Live days: $LiveDay days,Remaining Days: $RemainingDay days
echo $WeekDay-$DateDay-$RemainingDay

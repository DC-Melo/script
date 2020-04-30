#!/bin/sh
echo '
-------------------------------------------------------------------------
| Time	: 2019-06-15
| Author: Melo.DC
| Email	: melo.dachar@gmail.com
| File	: ss2readme.sh
| Param.: filepath, png file name
| Exam.	: ss2readme.sh doc png
------------------------------------------------------------------------
'

# check parameter
if [ $# -eq 0 ]; then
	echo "missing parameter."
	exit
fi

# make path 
if [ ! -d $1/res  ];then
  mkdir -p $1/res
  echo make dir $1/res
fi

#screen shot and save file 
pngfilename=$2-`date +%Y-%m-%d-%H-%M-%S`.png
echo $OSTYPE
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo  under GNU/Linux platform
    gnome-screenshot -d 1 -f $1/res/$pngfilename
elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo  under Mac OS X platform        
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


echo '<img src="./res/'$pngfilename'" alt="'$2'"/> ' >> $1/readme.html

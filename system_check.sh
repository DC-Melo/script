#!/bin/sh
echo '
-------------------------------------------------------------------------
| Time	: Wed Apr 29 21:34:21 CST 2020
| Author: Melo.DC
| Email	: melo.dachar@gmail.com
| Func.	: check system type shell code 
| Param.: None
| Exam.	: 
------------------------------------------------------------------------
'

echo $OSTYPE
if [[ "$OSTYPE" == "linux-gnu" ]]; then
    echo  under GNU/Linux platform
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

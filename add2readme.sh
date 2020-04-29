#!/bin/bash
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
gnome-screenshot -d 1 -f $1/res/$pngfilename
echo '<img src="./res/'$pngfilename'" alt="'$2'"/> ' >> $1/readme.html

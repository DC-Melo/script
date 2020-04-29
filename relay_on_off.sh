# stty -F /dev/ttyUSB1 raw speed 9600 min 0 time 10
port='/dev/ttyUSB1'
stty -F $port 9600 cs8 -cstopb -parenb
# stty -F $port 9600 cs8 -cstopb -parenb
# 全开发送码：FE 0F 00 00 00 04 01 FF 31 D2
# 全断发送码：FE 0F 00 00 00 04 01 00 71 92
for i in {1..1}
do
    echo 第$i次断开USB"\xFE\x0F\x00\x00\x00\x04\x01\xFF\x31\xD2"
    # cat /dev/ttyUSB1 &
    echo -en "\xFE\x0F\x00\x00\x00\x04\x01\xFF\x31\xD2" > $port
    read -N 10 -t 3 XChar < /dev/ttyUSB1
    echo $XChar
    echo 第$i次接通USB"\xFE\x0F\x00\x00\x00\x04\x01\x00\x71\x92"
    echo -en "\xFE\x0F\x00\x00\x00\x04\x01\x00\x71\x92" > $port
    read -N 10 -t 3 XChar < /dev/ttyUSB1
    echo $XChar
done

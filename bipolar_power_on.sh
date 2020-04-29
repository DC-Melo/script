# stty -F /dev/ttyUSB1 raw speed 9600 min 0 time 10
port='/dev/ttyUSB0'
echo 'set port'
# stty -F $port 9600 cs8 -cstopb -parenb
stty -F $port 19200 cs8 -cstopb -parenb
sleep 1
echo -en '*IDN?'
echo -en "*IDN?\r\n" > $port
read -t 1 -r ligne < /dev/ttyUSB0
echo $ligne

echo -en 'syst:err?'
echo -en "syst:err?\r\n" > $port
read -t 1 -r ligne < /dev/ttyUSB0
echo $ligne

echo -en 'syst:rem'
echo -en "syst:rem\r\n" > $port
read -t 1 -r ligne < /dev/ttyUSB0
echo $ligne

echo -en 'outp:stat on'
echo -en "outp:stat on\r\n" > $port
read -t 1 -r ligne < /dev/ttyUSB0
echo $ligne

for i in {1..1}
do
    echo 第$i次
    echo -en 'sour:volt 0'
    echo -en "sour:volt 0\r\n" > $port
    read -t 1 -r ligne < /dev/ttyUSB0
    echo $ligne
    echo -en 'meas:volt?'
    echo -en "meas:volt?\r\n" > $port
    read -t 1 -r ligne < /dev/ttyUSB0
    echo $ligne

    echo -en 'sour:volt 12'
    echo -en "sour:volt 12\r\n" > $port
    read -t 1 -r ligne < /dev/ttyUSB0
    echo $ligne

    echo -en 'meas:volt?'
    echo -en "meas:volt?\r\n" > $port
    read -t 1 -r ligne < /dev/ttyUSB0
    echo $ligne

    echo -en 'meas:curr?'
    echo -en "meas:curr?\r\n" > $port
    read -t 1 -r ligne < /dev/ttyUSB0
    echo $ligne
done


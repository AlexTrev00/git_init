#!/bin/bash
'''
script bash que detecta que tipo de sistema operativo tienes
'''
if type -t wevtutil &> /dev/null
then
	OS=MSWin
elif type -t scutil &> /dev/null
then
	OS=MacOs
else
	OS=Linux
fi
echo $OS
function is_alive_ping(){
	ping -c 1 $1 > /dev/null 2>&1
	[$? -eq 0] && IPS=$i
}
for i in 192.168.1.{1..99}
do
	is_alive_ping $i & disown


done
firstport=10
lastport=500
for $i in "${IPS[@]}"
do
	counter=$firstport; counter<=$lastport; counter++
	echo "$i $counter"
done

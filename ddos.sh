#!/bin/bash
#########################################################################
# File Name: ddos.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/6/11 14:11:23
# Description:
# Vierson 1.0
#########################################################################


file=$1

judeExt(){
if expr "$1":".*\.log" &>/dev/null
then
	:
else
	echo $"usage:$0 xxxx.log"
	exit 1
fi
}

ipCount(){
grep "ESTABLISHED" $1|awk -F "[ :]+" '{ ++S[$(NF-3)]}END {for(key in S)print S[key],key}'|sort -rn -k1|head -5 >/tmp/tmp.log
}

ipt(){
local ip=$1
if [ `iptables -L -n|grep "$ip"|wc -l` -lt 1 ]
then
	iptables -I INPUT -s $ip -j DROP
	echo "$line is dropped." >>/tmp/droplist_$(date +%F).log
fi
}


main(){
judeExt $file
while true
do
	ipCount $file
	while read line
	do
		ip=`echo $line|awk '{pring $2}'`
		count=`echo $line|awk '{print $1}'`
		if [ $count -gt 3 ]
		then
			ipt $ip
		fi
	done
	sleep 180
done
}

main
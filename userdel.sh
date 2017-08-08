#!/bin/bash
#########################################################################
# File Name: sys_Optimization.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/2/15 23:03:25 
# Description:批量删除用户
# Vierson 1.0
#########################################################################
. /etc/init.d/functions		#inmport sys functions

rootId=0

echo "Welcome to use userdel scripts."
echo "TIP: Must be root to run this script"
echo "Please Waiting..."
sleep 2
action "Loading completed." /bin/true
clear

echo "Checking permissions..."
echo "Please waitting..."
sleep 1

if [ "$rootId" -eq "$UID" ]
	then
		action "Permissions passed." /bin/true
else
	action "Permissions failed." /bin/false
	exit 1
fi


read -p "Input the number of users you want to delete:" num
read -p "Input the format of username you defined:" char

action "Prepare operating..." /bin/true
sleep 3

for((i=1;i<=$num;i++))
	do
		userdel -r $char$i
		action "user:$char$i delete successful." /bin/true
done
action "All operat have done." /bin/true
echo "Thank you for using..."
sleep 2
exit 0

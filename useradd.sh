#!/bin/bash
#########################################################################
# File Name: useradd.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/2/15 22:41:29 
# Description:批量添加用户
# Vierson 1.0
#########################################################################
. /etc/init.d/functions		#inmport sys functions

rootId=0

echo "Welcome to use useradd scripts."
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

userDb=/server/log/userlist.log

read -p "Input the number of users you want to creat:" num
read -p "Input the prefix format of username you want:" char

action "Prepare operating..." /bin/true
sleep 3

for((i=1;i<=$num;i++))
	do
		userName=$char$i
		passWd=`uuidgen|md5sum|cut -c 1-10|tr '0-9' 'a-z'`

		useradd $userName &>/dev/null && echo $passWd|passwd --stdin $char$i &>/dev/null
		if [ $? -eq 0 ]
			then
				action "${userName} added successful." /bin/true
				echo "username:$userName;password:$passWd" >>$userDb
		else
			action "${userName} added failed." /bin/false
			echo "username:${userName}added failed." >>$userDb
		fi

done
action "All operat have done." /bin/true
echo "Thank you for using..."
sleep 2
exit 0






	

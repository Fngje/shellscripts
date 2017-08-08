#!/bin/bash
#########################################################################
# File Name: sys_Optimization.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/4/13 21:06:55 
# Description:
# Vierson 1.0
#########################################################################
. /etc/init.d/functions		#inmport sys functions

#ip 172.16.1.51 172.16.1.41 172.16.1.31 172.16.1.5 172.6.1.6 172.16.1.7 172.6.1.8
rm -rf /root/.ssh/ && ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa>/dev/null 2>&1

if [ `rpm -qa|grep sshpass|wc -l` -eq 0 ]
	then
	yum install sshpass -y
fi
for ip in `cat $1`
	do
	sshpass -p123456 ssh-copy-id -i /root/.ssh/id_dsa.pub "-o StrictHostKeyChecking=no root@$ip" >/dev/null 2>&1
	ssh root@$ip hostname;
	if [ $? -eq 0 ]
		then
			action "ssh-key send to $ip successful." /bin/true
	else
		action "ssh-key send to $ip failed." /bin/false
	fi
done
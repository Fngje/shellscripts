#!/bin/bash
#########################################################################
# File Name: sys_check.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/3/22 23:06:55
# Description:
# Vierson 1.0
#########################################################################
. /etc/init.d/functions		#inmport sys functions

#set env
export PATH=$PATH:/bin:/sbin:/usr/sbin

function permissionchk(){

#Require root to run this script
echo "Permission checking..."
sleep 2

if [ $UID -eq "0" ]
	then
		action "Permission check successful." /bin/true
else
	action "Permission check faild." /bin/false
	echo "Must be root to run this script."
	exit 1
fi

}


#Source function library.

function check_yum(){

	Base=/etc/yum.repos.d/CentOS-Base.repo
	if [ `grep aliyun $Base|wc -l` -ge "1" ]
		then
			action "$Base config" /bin/true
	else
		action "$Base config" /bin/false		

	fi

}


function check_selinux(){

	config=/etc/selinux/config
	if [ `grep "SELINUX=disabled" $config|wc -l` -ge "1" ]
		then
			action "$config config" /bin/true
	else
		action "$config config" /bin/false
	fi

}


function check_service(){

	export LANG=env
	if [ `chkconfig|grep 3:on|egrep "crond|sshd|network|rsyslog|sysstat"|wc -l` -eq "5" ]
		then
			action "system service init" /bin/true
	else
		action "system service init" /bin/false
	fi

}

function check_open_file(){

	limits=/etc/security/limits.conf
	if [ `grep 65535 $limits|wc -l` -eq "1" ]
		then
			action "$limits" /bin/true
	else
		action "$limits" /bin/false
	fi

}

main (){

permissionchk
check_yum
check_selinux
check_service
check_open_file

}

main


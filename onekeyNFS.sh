#!/bin/bash
#########################################################################
# File Name: onekeyNFS.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/5/11 19:06:55 
# Description:
# Vierson 1.0
#########################################################################


#Check whether the NFS service is installed if not install it
#检查NFS软件是否安装，如果没有安装它
if [ `rpm -qa nfs-utils|wc -l` -lt 1 ]
	then
		yum install nfs-utils -y
fi
	
#Check whether the rpcbind service is installed if not install it
if [ `rpm -qa rpcbind|wc -l` -lt 1 ]
	then
		yum install rpcbind -y
fi

#Check whether the rpcbind service is start,if not start it
if [ `ps -ef|grep rpcbind|wc -l` -lt 2 ]
	then
		/etc/init.d/rpcbind start
		sleep 1;
fi
#Check whether the NFS service is start,if not start it
if [ `ps -ef|grep nfs|wc -l` -lt 2 ]
	then
		/etc/init.d/nfs start
		sleep 1;
fi

#edit the  configuration file of NFS,You can make changes as needed
cat >>/etc/exports<<EOF
/data/www 172.16.1.0/24(rw,sync,all_squash)
/data/blog 172.16.1.0/24(rw,sync,all_squash)
/data/bbs 172.16.1.0/24(rw,sync,all_squash)
EOF

mkdir -p /data/{www,bbs,blog}
chown nfsnobody.nfsnobody /data/

#reload nfs server
exportfs -rv
sleep 1;
showmount -e localhost

sleep 2;
clear;

echo "onkey successful."
exit 0;

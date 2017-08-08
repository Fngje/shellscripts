#!/bin/bash
#########################################################################
# File Name: backupsk.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/3/19 21:33:01
# Description:
# Vierson 1.0
#########################################################################

Host_IP=$(hostname -I|awk '{print $2}')
Date_info=$(date +%F_week0%w)

mkdir -p /backup/$Host_IP


#tar data On the local server
cd / &&\
tar zchf /backup/$Host_IP/sys_data_${Date_info}.tar.gz var/spool/cron/root etc/rc.local server/scripts/ etc/sysconfig/iptables
tar zchf /backup/$Host_IP/www_data_${Date_info}.tar.gz var/html/www/
tar zchf /backup/$Host_IP/logs_data_${Date_info}.tar.gz app/logs/

#md5sum data
find /backup/$Host_IP/ -type f -name "*${Date_info}.tar.gz"|xargs md5sum >/backup/$Host_IP/finger_${Date_info}.txt

#rsync push data to rsync_server
rsync -az /backup/$Host_IP rsync_backup@172.16.1.41::backup --password-file=/etc/rsync.password

#del 7days ago data
find /backup/$Host_IP/ -type f -mtime +7 -name "*.tar.gz" |xargs rm -f
find /backup/$Host_IP/ -type f -mtime +7 -name "*finger*" |xargs rm -f

#!/bin/bash
#########################################################################
# File Name: check_rsync.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/3/19 22:06:55 
# Description:
# Vierson 1.0
#########################################################################


Date_info=$(date +%F_week0%w)

# check data info
find /backup/ -type f -name "finger_${Date_info}.txt"|xargs md5sum -c >/tmp/figer_check.txt 2>&1

#send mail of check result
mail -s "Check result $(date +%F)" fngje0128@163.com </tmp/figer_check.txt

#del 180days ago except monday
find /backup/ -type f -mtime +180 ! -name "*week01.tar.gz"|xargs rm -f

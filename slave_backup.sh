#!/bin/bash
#########################################################################
# File Name: slave_backup.sh
# Author: Fngje
# mail:fngje0128@163.com
# Created Time:2017/5/13 9:12:09
# Description:
# Vierson 1.0
#########################################################################


PATH="/application/mysql/bin:PATH"
DBPATH="/server/backup"
MYUSER=root
MYPSSWD=Vu39hbnx.
SOCKET=/data/3306/mysql.sock
MYCMD="mysql -u$MYUSER -P$MYPSSWD -S $SOCKET"
MYDUMP="mysqldump -u$MYUSER -p$MYPSSWD -S $SOCKET"
[ ! -d "$DBPATH" ] && makdir -p $DBPATH

for dbname in `$MYCMD -e "show databases;"|sed '1,2d'|egrep -v "mysql|scheam"`
do
	$MYDUMP $dbname|gzip >$DBPATH/${dbname}_$(date +%F).sql.gzip
done
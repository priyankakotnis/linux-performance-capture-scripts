#!/usr/bin/env bash
DATE=`date +%Y%m%d-%H%M%S`
PIDSTAT_LOGFILE_NAME=zk_pidstat_log_$DATE.txt
LOGDIR=stats
touch ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
echo "Started at $DATE ======================================" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
while true;
do
ZK_PIDS=`ps aux | grep 'zookeeper/zookeeper-3.4.8' | grep -v grep | awk '{print $2}' | tr "\\n" "," | sed 's/,$//'`
if [ "x$ZK_PIDS" == "x" ];
then
	echo "No zookeeper processes found at `date +%Y%m%d-%H%M%S`" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME	
else 
	pidstat -p $ZK_PIDS 1 1 >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME  & 
fi
sleep 5
done


#!/usr/bin/env bash
DATE=`date +%Y%m%d-%H%M%S`
PIDSTAT_LOGFILE_NAME=kafka_pidstat_log_$DATE.txt
LOGDIR=stats
touch ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
echo "Started at $DATE ======================================" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
while true;
do
KAFKA_PIDS=`ps aux | grep 'kafka/kafka_2.11-0.10.0.0' | grep -v grep | awk '{print $2}' | tr "\\n" "," | sed 's/,$//'`
if [ "x$KAFKA_PIDS" == "x" ];
then
	echo "No kafka processes found at `date +%Y%m%d-%H%M%S`" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME	
else 
	pidstat -p $KAFKA_PIDS 1 1 >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME  & #echo  $! >> ./storm_logs/$PIDS_FILE_NAME
fi
sleep 5
done


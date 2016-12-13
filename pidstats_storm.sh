#!/usr/bin/env bash
DATE=`date +%Y%m%d-%H%M%S`
PIDSTAT_LOGFILE_NAME=storm_pidstat_log_$DATE.txt
LOGDIR=stats
touch ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
echo "Started at $DATE ======================================" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
while true;
do
STORM_PIDS=`ps aux | grep -E 'daemon.name=nimbus|daemon.name=supervisor|daemon.name=ui|TridentKafkaWordCount|TridentKafkaGrep|daemon.name=drpc' | grep -v 'zookeeper/zookeeper-3.4.8'  | grep -v grep | awk '{print $2}' | tr "\\n" "," | sed 's/,$//'`
if [ "x$STORM_PIDS" == "x" ];
then
	echo "No storm processes found at `date +%Y%m%d-%H%M%S`" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME	
else 
	pidstat -p $STORM_PIDS 1 1 >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME  & 
fi
sleep 5
done


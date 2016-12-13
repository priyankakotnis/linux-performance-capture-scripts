#!/usr/bin/env bash
DATE=`date +%Y%m%d-%H%M%S`
PIDSTAT_LOGFILE_NAME=spark_pidstat_log_$DATE.txt
LOGDIR=stats
touch ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
echo "Started at $DATE ======================================" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME
while true;
do
SPARK_PIDS=`ps aux | grep -E 'spark/spark-1.6.2-bin-hadoop2.6|org.apache.spark.deploy.history.HistoryServer|org.apache.spark.deploy.master.Master|org.apache.spark.deploy.worker.Worker' | grep -v grep | awk '{print $2}' | tr "\\n" "," | sed 's/,$//'`
if [ "x$SPARK_PIDS" == "x" ];
then
	echo "No spark processes found at `date +%Y%m%d-%H%M%S`" >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME	
else 
	pidstat -p $SPARK_PIDS 1 1 >> ./$LOGDIR/$PIDSTAT_LOGFILE_NAME  & 
fi
sleep 5
done


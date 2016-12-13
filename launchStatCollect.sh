#!/usr/bin/env bash
DATE=`date +%Y%m%d-%H%M%S`
TOP_LOGFILE_NAME=top_log_$DATE.txt
SAR_LOGFILE_NAME=sar_log_$DATE.txt
PIDS_FILE_NAME=pids_$DATE.txt
SCRIPT_DIR=`dirname $0`
LOGS_DIR=${SCRIPT_DIR}/../stats
DURATION=5
USER_NAME=${USER}
if [ "$#" != "0" ];
then
	DURATION=$1
	echo "Running for duration : $DURATION : iterations of 5 seconds"
fi
mkdir -p ${LOGS_DIR}
touch ${LOGS_DIR}/$TOP_LOGFILE_NAME
touch ${LOGS_DIR}/$SAR_LOGFILE_NAME
touch ${LOGS_DIR}/$PIDS_FILE_NAME
echo "Started at $DATE ======================================" >> ${LOGS_DIR}/$TOP_LOGFILE_NAME
echo "Top PID:" >> ${LOGS_DIR}/$PIDS_FILE_NAME
top -n$DURATION -b -d 5 -u ${USER_NAME} >>  ${LOGS_DIR}/$TOP_LOGFILE_NAME & echo  $! >> ${LOGS_DIR}/$PIDS_FILE_NAME
echo "Sar PID:" >> ${LOGS_DIR}/$PIDS_FILE_NAME
echo "Started at $DATE ======================================" >> ${LOGS_DIR}/$SAR_LOGFILE_NAME
sar -u 5 $DURATION >> ${LOGS_DIR}/$SAR_LOGFILE_NAME & echo  $! >> ${LOGS_DIR}/$PIDS_FILE_NAME


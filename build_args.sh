#!/bin/sh

#ARG1=DepSpace IP
#ARG2=DepSpace Port

if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <IP> <Port>"
  exit 1
fi

IP=$1
PORT=$2
CURRENT_DIR=`pwd`
LOG_FILE="$CURRENT_DIR/build.log"

#deleting previous log file
rm -f "$LOG_FILE"

echo "------------------ Installing DepSpacito ------------------" | tee -a "$LOG_FILE"
echo "IP: $IP" | tee -a "$LOG_FILE"
echo "Port: $Port" | tee -a "$LOG_FILE"

echo "Configuring hosts.config..." | tee -a "$LOG_FILE"
rm config/hosts.config
echo "0 $IP $PORT" > config/hosts.config

echo "----------------------- mvn clean ----------------------- " >> $LOG_FILE
echo "Executing: mvn clean"
mvn --quiet clean 2>&1 | tee -a $LOG_FILE
echo "" >> $LOG_FILE

echo "----------------------- mvn install -----------------------" >> $LOG_FILE
echo "Executing: mvn compile"
mvn --quiet compile | tee -a $LOG_FILE
echo "" >> $LOG_FILE

echo "Done. Log file -> $LOG_FILE" | tee -a "$LOG_FILE"

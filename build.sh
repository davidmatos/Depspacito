#!/bin/sh

#ARG1=MPM IP Address

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <MPM IP Address>"
  echo "This machine has the following IP Addresses:"
  hostname -I
  exit 1
fi

MPM_IP_ADDRESS=$1
CURRENT_DIR=`pwd`
LOG_FILE="$CURRENT_DIR/build.log"

#deleting previous log file
rm -f "$LOG_FILE"

echo "" | tee -a "$LOG_FILE"
echo "Configuring hosts.config..." | tee -a "$LOG_FILE"
echo "MPM IP:$MPM_IP_ADDRESS" | tee -a "$LOG_FILE"
rm config/hosts.config
echo "0 $MPM_IP_ADDRESS 11000" > config/hosts.config

echo "------------------ Installing DepSpacito ------------------" | tee -a "$LOG_FILE"
echo "----------------------- mvn clean ----------------------- " >> $LOG_FILE
echo "Executing: mvn clean"
mvn clean >> $LOG_FILE
echo "" >> $LOG_FILE
echo "----------------------- mvn install -----------------------" >> $LOG_FILE
echo ""
echo ""
echo "Executing: mvn compile"
mvn compile >> $LOG_FILE
echo "" >> $LOG_FILE
echo "" >> $LOG_FILE

echo "Done. For more information consult the build log -> $LOG_FILE" | tee -a "$LOG_FILE"



#!/bin/sh

#ARG1=MPM IP Address

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <MPM IP Address>"
  echo "This machine has the following IP Addresses:"
  hostname -I
  exit 1
fi

#deleting previous build.log file
rm -f build.log

MPM_IP_ADDRESS=$1
CURRENT_DIR=`pwd`
LOG_FILE="$CURRENT_DIR/build.log"

echo "" | tee -a "$LOG_FILE"
echo "Configuring hosts.config..." | tee -a "$LOG_FILE"
#MP David Why the message below ?
#echo "Installing SCNodeCode..." | tee -a "$LOG_FILE"
echo "MPM IP:$MPM_IP_ADDRESS" | tee -a "$LOG_FILE"
#MP David Why the message below ?
#echo "Configuring MPM Adapter..." | tee -a "$LOG_FILE"
rm config/hosts.config
echo "0 $MPM_IP_ADDRESS 11000" > config/hosts.config

echo "------------------ Installing DepSpacito ------------------" >> $LOG_FILE
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



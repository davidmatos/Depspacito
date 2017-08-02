#!/bin/sh

if [ ! $# -eq 1 ]; then
	echo "Usage $0 <ClientID>"
	echo "Possible client ids = [1001-1002]"
	exit
fi
$CLIENT_ID=$1
mvn exec:java -P client -Dclient.id=$CLIENT_ID


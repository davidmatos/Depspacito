#!/bin/sh

if [ ! $# -eq 1 ]; then
	echo "Usage $0 <ClientID>"
	exit
fi
CLIENT_ID=$1
mvn exec:java -P client -Dclient.id=$CLIENT_ID

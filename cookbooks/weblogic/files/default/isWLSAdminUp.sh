#!/bin/bash

#  This script will check the Medrec Admin server 4 times 
#  until it gets back a response other than Failed. 
#  If it does not receive any response other than Failed
#  4 times in a row then we exit with a error code of 1.

echo "first need to set the environment"

. /opt/dsg/bin/setWLSEnv.sh

COUNT=0

function adminTest {

	echo "now lets ping the t3 listen on the admin server"

	java weblogic.Admin -adminurl $ADMIN_URL -username weblogic -password welcome1 PING
	
	if [ $? -ne 0 ] ;
	then
		echo "The admin server is not running. Lets wait for about 10 seconds and check is again......"
		sleep 10
		COUNT=$((COUNT + 1))
		echo "$COUNT"
		if [ $((COUNT)) -gt  3 ] ;
		then
			echo "We checked for the admin server 4 times with no luck. We are going to exit with code 1"
			exit 1
		fi
		adminTest
	else
		echo "The admin server is good to go"
		exit 0
	fi
}

ADMIN_URL=$1
adminTest



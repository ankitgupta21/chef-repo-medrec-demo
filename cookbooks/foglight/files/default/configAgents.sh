#!/bin/sh

. /opt/dsg/bin/fglSetEnv.sh

echo "set JAVA_HOME to ${JAVA_HOME}"

HOSTNAME=`hostname`

echo "hostname is set to ${HOSTNAME}"


function createAgents
{
	fglcmd.sh -cmd agent:create -name ${HOSTNAME}_linux -type Linux_System -host ${HOSTNAME}
	echo "LInux_System agent create done"
	fglcmd.sh -cmd agent:create -name ${HOSTNAME}_app -type AppMonitor -host ${HOSTNAME}
	echo "AppMonitor agent create done"
	
}

function deployPackage
{
	fglcmd.sh -cmd agent:deploy -packageos "linux" -clientid ${CLIENT_ID} 
	createAgents
}

function testClient
{
	CLIENT_ID=`fglcmd.sh -cmd agent:clients -host ${HOSTNAME} | grep "Client ID" | sed 's/Client ID: //g' | sed -e 's/\r//g'`

	echo "CLIENT_ID is set to ${CLIENT_ID}"
	
	if [ "${FAILED}" = "true" ] ;
	then
		FAILED="twice"
	fi
	
	if [ "${CLIENT_ID}" = "" ] ;
	then
		echo "CLIENT_ID is null, waiting 10 seconds before trying again"
		sleep 10
		
		if [ "${FAILED}" = "last" ] ;
		then
			echo "We failed to get a valid Agent Manager client id 3 times so we must exit"
			exit1
		else
			if [ "${FAILED}" = "twice" ] ;
			then
				echo "this is our second time to fail"
				FAILED="last"
			else
				echo "This is the first time to fail"
				FAILED="true"
			fi
			testClient
		fi
	else 
		echo "The agent manager is ready" 
		deployPackage	
		echo "deploy packages complete"
	fi
}

testClient

echo "done creating agents trying to activate now"

fglcmd.sh -cmd agent:activate -host ${HOSTNAME} -force



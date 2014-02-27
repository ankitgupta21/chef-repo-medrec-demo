#!/bin/sh

. /opt/dsg/bin/fglSetEnv.sh

echo "set JAVA_HOME to ${JAVA_HOME}"

HOSTNAME=`hostname`

echo "hostname is set to ${HOSTNAME}"


function createAgents
{
	fglcmd.sh -cmd agent:create -name "${HOSTNAME}Nexus" -type Nexus -host ${HOSTNAME}
	echo "Nexus agent on the admin server successful"
	fglcmd.sh -cmd agent:activate -name "${HOSTNAME}Nexus" -type Nexus -host ${HOSTNAME}
	echo "Nexus agent activation on the admin server successful"	
	fglcmd.sh -cmd agent:start -name "${HOSTNAME}Nexus" -type Nexus -host ${HOSTNAME}
	echo "Nexus agent started on the admin server was successful"	
}

function deployPackage
{
	fglcmd.sh -cmd agent:deploy -packageid "ApplicationServers-Nexus-5.9.4-ApplicationServers-Nexus" -clientid ${CLIENT_ID} 
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
		echo "deploy Nexus packages complete"
	fi
}

testClient




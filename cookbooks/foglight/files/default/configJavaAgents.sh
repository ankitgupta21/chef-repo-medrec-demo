#!/bin/sh

. /opt/dsg/bin/fglSetEnv.sh

echo "set JAVA_HOME to ${JAVA_HOME}"

HOSTNAME=`hostname`

echo "hostname is set to ${HOSTNAME}"


function createAgents
{
	fglcmd.sh -cmd jmx:createagent -name ${HOSTNAME}JMX -host ${HOSTNAME} -serverModel medrec -jmxServiceUrl "service:jmx:t3://medrecAdmin:7011/jndi/weblogic.management.mbeanservers.runtime" -classpath "/root/Oracle/Middleware/wlserver_10.3//server/lib/weblogic.jar" -envProps "jmx.remote.protocol.provider.pkgs=weblogic.management.remote" -activate true
}

function deployPackage
{
	fglcmd.sh -cmd agent:deploy -packageid "JMXCartridge-5.8.1-JMXAgent" -clientid ${CLIENT_ID} 
	fglcmd.sh -cmd agent:deploy -packageid "JMXCartridge-5.8.1-JMXDiscoveryAgent" -clientid ${CLIENT_ID} 
	createAgents
}

function createJavaAgent
{
	cd /opt/dsg/Foglight_Agent/Manager/agents
	tar -xvf JavaEE_agent.tar
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
		#deployPackage
		createJavaAgent
		echo "deploy packages complete"
	fi
}

testClient




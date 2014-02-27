#!/bin/sh

# WARNING: This file is created by the Configuration Wizard.
# Any changes to this script may be lost when adding extensions to this configuration.

# --- Start Functions ---

usage()
{
	echo "Need to set SERVER_NAME and ADMIN_URL environment variables or specify"
	echo "them in command line:"
	echo "Usage: $1 SERVER_NAME {ADMIN_URL}"
	echo "for example:"
	echo "$1 managedserver1 http://test-medrec:7011"
}

# --- End Functions ---

# *************************************************************************
# This script is used to start a managed WebLogic Server for the domain in
# the current working directory.  This script can either read in the SERVER_NAME and
# ADMIN_URL as positional parameters or will read them from environment variables that are 
# set before calling this script. If SERVER_NAME is not sent as a parameter or exists with a value
# as an environment variable the script will EXIT. If the ADMIN_URL value cannot be determined
# by reading a parameter or from the environment a default value will be used.
# 
#  For additional information, refer to "Managing Server Startup and Shutdown for Oracle WebLogic Server"
#  (http://download.oracle.com/docs/cd/E17904_01/web.1111/e13708/overview.htm)
# *************************************************************************

#  Set SERVER_NAME to the name of the server you wish to start up.

#  Verify there is a running admin server to start with otherwise don't start.
SERVER_NAME=$1
ADMIN_URL=$2

/opt/dsg/bin/isWLSAdminUp.sh $ADMIN_URL

if [ $? -eq 0 ] ;
then
	echo "The admin server at $2 is good to go"
else
	echo "No admin server could be found or connected to at $2"
	exit
fi

DOMAIN_NAME="medrec"


#  Set WLS_USER equal to your system username and WLS_PW equal  

#  to your system password for no username and password prompt 

#  during server startup.  Both are required to bypass the startup

#  prompt.

. /root/Oracle/Middleware/wlserver_10.3/common/bin/commEnv.sh

WLS_USER="weblogic"
export WLS_USER

WLS_PW="welcome1"
export WLS_PW

#  Set JAVA_OPTIONS to the java flags you want to pass to the vm. i.e.: 

#  set JAVA_OPTIONS=-Dweblogic.attribute=value -Djava.attribute=value

JAVA_OPTIONS="-Djava.security.egd=file:/dev/./urandom -Dweblogic.security.SSL.trustedCAKeyStore="/root/Oracle/Middleware/wlserver_10.3/server/lib/cacerts" ${JAVA_OPTIONS}"
export JAVA_OPTIONS

#  Set JAVA_VM to the java virtual machine you want to run.  For instance:

#  set JAVA_VM=-server

JAVA_VM=""

#  Set SERVER_NAME and ADMIN_URL, they must by specified before starting

#  a managed server, detailed information can be found at

# http://download.oracle.com/docs/cd/E17904_01/web.1111/e13708/overview.htm

ADMIN_URL="${ADMIN_URL}"
export ADMIN_URL

SERVER_NAME="${SERVER_NAME}"
export SERVER_NAME

DOMAIN_HOME="/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec"

${DOMAIN_HOME}/bin/startWebLogic.sh nodebug noderby noiterativedev notestconsole noLogErrorsToConsole


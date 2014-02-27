#!/bin/sh

ADMIN_HOST="${1}"
HOSTNAME=`hostname`
IP_ADDR="${2}"
SERVER_NAME="${HOSTNAME}MS"

ADMIN_IP="${ADMIN_HOST}:7011"
USERNAME="weblogic"
PASSWORD="welcome1"
DOMAIN="medrec"

. /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/bin/setDomainEnv.sh

echo "${CLASSPATH}"
echo "${ADMIN_IP}"
echo "${USERNAME}"
echo "***********"
echo "${SERVER_NAME}"
echo "${DOMAIN}"

cat /dev/null > /etc/hosts

echo "127.0.0.1   localhost localhost.localdomain" >> /etc/hosts
echo "${ADMIN_HOST} medrecAdmin" >> /etc/hosts
echo "12.173.168.211 foglight" >> /etc/hosts
echo "${IP_ADDR} $HOSTNAME" >> /etc/hosts

#CREATE_STATUS=$(java -classpath ${CLASSPATH} weblogic.Admin \
#   -url t3://${ADMIN_IP} \
#   -username $USERNAME -password $PASSWORD CREATE \
#   -type Server \
#   -name ${SERVER_NAME} \
#   -domain ${DOMAIN})
#
#echo "CREATE_STATUS:${CREATE_STATUS} for ${SERVER_NAME}"
#
#LISTEN_PORT_STATUS=$(java -classpath ${CLASSPATH} weblogic.Admin \
#	-url t3://${ADMIN_IP} \
#	-username $USERNAME \
#	-password $PASSWORD SET \
#	-mbean ${DOMAIN}:Type=Server,Name=${SERVER_NAME} \
#	-property ListenPort 8011)
#
#
#echo "	LISTEN_PORT_STATUS:${LISTEN_PORT_STATUS}"
#

/opt/dsg/bin/isWLSAdminUp.sh $ADMIN_IP

if [ $? -eq 0 ] ;
then
	echo "The admin server at $2 is good to go"
else
	echo "No admin server could be found or connected to at $2"
	exit
fi

LISTEN_ADDRESS_STATUS=$( java -classpath ${CLASSPATH} weblogic.Admin \
	-url t3://${ADMIN_IP} \
	-username $USERNAME \
	-password $PASSWORD SET \
	-mbean ${DOMAIN}:Type=Server,Name=${SERVER_NAME} \
	-property ListenAddress ${IP_ADDR})
		
echo "	LISTEN_ADDRESS_STATUS:${LISTEN_ADDRESS_STATUS}"

#SERVER_STATUS=$(java -classpath ${CLASSPATH} weblogic.Admin \
#	-url t3://${ADMIN_IP} \
#	-username $USERNAME \
#	-password $PASSWORD SET \
#	-mbean ${DOMAIN}:Type=Server,Name=${SERVER_NAME} \
#	-property Cluster ${DOMAIN}:Type=Cluster,Name=medrecCluster )
#
#echo "	SERVER_STATUS:$SERVER_STATUS Server ${SERVER_NAME} Joining Cluster medrecCluster"


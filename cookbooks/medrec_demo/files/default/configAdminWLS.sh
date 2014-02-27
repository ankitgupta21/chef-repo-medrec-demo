#!/bin/sh

# This is a version that I ran through dos2unix

HOSTNAME="${1}"

echo "setting hostname to $HOSTNAME"

cp -f /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/config.xml /root/config.xml

sed "s/test-medrec/$HOSTNAME/g" /root/config.xml > /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/config.xml

rm -f /root/config.xml




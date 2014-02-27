#!/bin/sh

echo "installing the Foglight Agent manager with the FSM url as $1"

/root/fglam-5_6_7_4-linux-ia32.bin --silent --fms url=$1 --installdir /opt/dsg/Foglight_Agent/Manager

/opt/dsg/Foglight_Agent/Manager/state/default/fglam-init-script-installer.sh install

/root/config_fgm.sh

/etc/init.d/quest-fglam start

/root/Oracle/Middleware/jdk160_21/jre/bin/keytool -noprompt -importcert -file /root/foglight_cert -alias foglightcert -keystore /root/Oracle/Middleware/jdk160_21/jre/lib/security/cacerts -storepass changeit

export JAVA_HOME=/root/Oracle/Middleware/jdk160_21

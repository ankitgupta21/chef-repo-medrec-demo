#!/bin/sh

sed "s/<config:upstream max-queue-size=\"-1\" max-disk-space=\"1024\" max-batch-size=\"500\"/<config:upstream max-queue-size=\"-1\" max-disk-space=\"100000\" max-batch-size=\"-1\"/g" /opt/dsg/Foglight_Agent/Manager/state/default/config/fglam.config.xml > /root/test.xml

sed "s/<config:upstream-verified max-queue-size=\"-1\" max-disk-space=\"512\" max-batch-size=\"250\"/<config:upstream-verified max-queue-size=\"-1\" max-disk-space=\"100000\" max-batch-size=\"-1\"/g" /root/test.xml > /opt/dsg/Foglight_Agent/Manager/state/default/config/fglam.config.xml

cp /opt/dsg/Foglight_Agent/Manager/state/default/config/vm.config /root/vm.config.tmp

sed "s/# vmparameter.0 = \"\";/  vmparameter.0 = \"-Xmx1024m\";/g" /root/vm.config.tmp > /opt/dsg/Foglight_Agent/Manager/state/default/config/vm.config

echo "Fisnished updating Agent Manager configurations"


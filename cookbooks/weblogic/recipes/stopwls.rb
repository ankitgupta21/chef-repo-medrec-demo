#
# Cookbook Name:: weblogic
# Recipe:: stopwls
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

execute "stop wls" do
	command "sh /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/binstopWebLogic.sh weblogic welcome1 t3://localhost:7011"
end


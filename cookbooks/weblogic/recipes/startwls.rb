#
# Cookbook Name:: weblogic
# Recipe:: startwls
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

execute "start weblogic" do
	command "sh /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/startWebLogic.sh > /root/weblogic.out &"
end



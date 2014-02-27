#
# Cookbook Name:: weblogic
# Recipe:: startManagedwls
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

wls = data_bag_item("WebLogic", "main")
adminIP = wls['adminIP']
hostname = node['hostname']

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/bin/startManagedWebLogic.sh" do
		source "startManagedWebLogic.sh"
		mode 0755
	end

	
#execute "start managedServer" do
#	command "sh /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/bin/startManagedWebLogic.sh #{hostname}MS #{adminIP}:7011 > /root/weblogic.out &"
#end




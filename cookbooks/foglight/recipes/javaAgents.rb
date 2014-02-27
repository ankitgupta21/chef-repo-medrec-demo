#
# Cookbook Name:: foglight
# Recipe:: javaAgents
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

wls = data_bag_item("WebLogic", "main")
adminIP = wls['adminIP']
hostname = node['hostname']

cookbook_file "/root/configJavaAgents.sh" do
        source "configJavaAgents.sh"
        mode 0755
end

cookbook_file "/opt/dsg/Foglight_Agent/Manager/agents/JavaEE_agent.tar" do
        source "JavaEE_agent.tar"
        mode 0755
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/bin/startWebLogic.sh" do
		source "startWebLogic.sh"
		mode 0755
end

execute "launch agents" do
	command "sh /root/configJavaAgents.sh"
end

execute "start managedServer" do
	command "sh /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/bin/startManagedWebLogic.sh #{hostname}MS #{adminIP}:7011 > /root/weblogic.out &"
end





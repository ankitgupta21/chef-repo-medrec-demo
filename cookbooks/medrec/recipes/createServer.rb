#
# Cookbook Name:: weblogic
# Recipe:: createServer
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

wls = data_bag_item("WebLogic", "main")

adminIP = wls['adminIP']
ipaddress = node['ipaddress']

cookbook_file "/root/createServer.sh" do
	source "createServer.sh"
	mode 0755
end

execute "create managedServer" do
	command "sh /root/createServer.sh #{adminIP} #{ipaddress} > /root/createServer.out"
end





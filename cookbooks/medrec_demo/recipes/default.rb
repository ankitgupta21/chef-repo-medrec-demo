#
# Cookbook Name:: medrec_demo
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "aws"
hostname = node['hostname']

aws = data_bag_item("aws", "main")

cookbook_file "/root/configAdminWLS.sh" do
	source "configAdminWLS.sh"
	mode 755
end

execute "config server" do
	command "sh /root/configAdminWLS.sh #{hostname}"
end

execute "start weblogic" do
	command "sh /root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/startWebLogic.sh > /root/weblogic.out &"
end

aws_elastic_lb "orion_LB" do
	aws_access_key aws['aws_access_key_id']
	aws_secret_access_key aws['aws_secret_access_key']
	name "Orion-LB"
	action :register
end

	
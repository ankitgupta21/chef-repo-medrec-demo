#
# Cookbook Name:: weblogic
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "aws"
include_recipe "set_my_ip"

aws = data_bag_item("aws", "main")
wls = data_bag_item("WebLogic", "main")

adminServer = wls['adminServer']
adminIP = wls['adminIP']
hostname = node['hostname']

puts "hostname is #{hostname} and adminIP is #{adminIP} and adminServer is #{adminServer}"

include_recipe "weblogic::configwls"

if hostname == adminServer
then
	include_recipe "weblogic::startwls"
else
	include_recipe "weblogic::createServer"
	include_recipe "weblogic::startManagedwls"
	
	aws_elastic_lb "orion_LB" do
		aws_access_key aws['aws_access_key_id']
		aws_secret_access_key aws['aws_secret_access_key']
		name "Orion-LB"
		action :register
	end
end





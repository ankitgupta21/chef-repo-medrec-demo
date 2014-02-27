#
# Cookbook Name:: set_my_ip
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe "aws"

aws = data_bag_item("aws", "main")
wls = data_bag_item("WebLogic", "main")

adminServer = wls['adminServer']
hostname = node['hostname']

puts "checking if I am an admin server with my hostname = #{hostname} and adminServer = #{adminServer}"

if hostname == adminServer
then
	puts "I am a admin server"
	aws_elastic_ip "set_admin_server_ip" do
		aws_access_key aws['aws_access_key_id']
		aws_secret_access_key aws['aws_secret_access_key']
		ip wls['adminIP']
		action :associate
	end
else
	puts "I am a managed server"
end
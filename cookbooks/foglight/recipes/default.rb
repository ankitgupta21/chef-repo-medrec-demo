#
# Cookbook Name:: foglight
# Recipe:: default
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

wls = data_bag_item("WebLogic", "main")

adminServer = wls['adminServer']
adminIP = wls['adminIP']
hostname = node['hostname']

foglight = data_bag_item("foglight", "main")

fsm_url = foglight['fsm_url']

cookbook_file "/root/install_fglam.sh" do
        source "install_fglam.sh"
        mode 0755
end

cookbook_file "/root/config_fgm.sh" do
        source "config_fgm.sh"
        mode 0755
end

cookbook_file "/root/foglight_cert" do
        source "foglight_cert"
        mode 0644
end

cookbook_file "/root/fglcmd.properties" do
	source "fglcmd.properties"
	mode 0600
end

execute "install fglam" do
        command "sh /root/install_fglam.sh #{fsm_url}"
end

if hostname == adminServer
then
	include_recipe "foglight::createNexus"
else
	include_recipe "foglight::osAgents"
	include_recipe "foglight::javaAgents"
	
end


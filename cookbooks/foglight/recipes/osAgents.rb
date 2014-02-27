#
# Cookbook Name:: foglight
# Recipe:: osAgents
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/opt/dsg/bin/fglSetEnv.sh" do
        source "fglSetEnv.sh"
        mode 0755
end

cookbook_file "/root/configAgents.sh" do
        source "configAgents.sh"
        mode 0755
end

execute "launch agents" do
	command "sh /root/configAgents.sh > /root/createAgents.out"
end



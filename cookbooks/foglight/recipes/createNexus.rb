#
# Cookbook Name:: foglight
# Recipe:: createNexus
#
# Copyright 2013, Dell Software Inc.
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/opt/dsg/bin/fglSetEnv.sh" do
        source "fglSetEnv.sh"
        mode 0755
end

cookbook_file "/root/createNexus.sh" do
        source "createNexus.sh"
        mode 0755
end

execute "launch nexus" do
	command "sh /root/createNexus.sh > /root/createNexus.out"
end



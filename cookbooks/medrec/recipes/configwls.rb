#
# Cookbook Name:: weblogic
# Recipe:: configwls
#
# Copyright 2013, Dell Software Group
#
# All rights reserved - Do Not Redistribute
#

cookbook_file "/root/medrec.ear" do
	source "deployments/medrec.ear"
	mode 755
end

cookbook_file "/root/physician.ear" do
	source "deployments/physician.ear"
	mode 755
end

cookbook_file "/root/Plan.xml" do
	source "deployments/Plan.xml"
	mode 755
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/config.xml" do
	source "config/config.xml"
	mode 0644
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/jms/medrecclusterjms-jms.xml" do
	source "config/jms/medrecclusterjms-jms.xml"
	mode 0644
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/jms/clustersaferrorhandler-jms.xml" do
	source "config/jms/clustersaferrorhandler-jms.xml"
	mode 0644
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/diagnostics/MedRecWLDF.xml" do
	source "config/diagnostics/MedRecWLDF.xml"
	mode 0644
end

cookbook_file "/root/Oracle/Middleware/wlserver_10.3/samples/domains/medrec/config/jdbc/medrecDataSource-3049-jdbc.xml" do
	source "config/jdbc/medrecDataSource-3049-jdbc.xml"
	mode 0644
end

cookbook_file "/opt/dsg/bin/setWLSEnv.sh" do
	source "setWLSEnv.sh"
	mode 0755
end

cookbook_file "/opt/dsg/bin/isWLSAdminUp.sh" do
	source "isWLSAdminUp.sh"
	mode 0755
end









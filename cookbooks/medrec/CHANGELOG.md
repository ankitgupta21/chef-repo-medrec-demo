medrec CHANGELOG
==================

This file is used to list changes made in each version of the weblogic cookbook.

0.1.2
-----
- Vann Orton - Initial release of weblogic now renamed medrec :-)

- - -
Check the [Markdown Syntax Guide](http://daringfireball.net/projects/markdown/syntax) for help with Markdown.

The [Github Flavored Markdown page](http://github.github.com/github-flavored-markdown/) describes the differences between markdown on github and standard markdown.

0.1.1
-----
ran the file through dos2unix
0.1.2
-----
added ownershio info

0.1.3
------
added java weblogic.Admin scripts and conditional logic to configure admin servers and maanged servers.
0.1.4
------
added the fully clustered medrec domain configuration for build the admin server. upadte startManagedWebloGic.sh to set the commEnv.  JMS configuration looks good. jdbc may require a pool change or a DB server config modification.
0.1.5
-----
added the creation of both ear files and moved the deployment dir under the domain config on the admin server
0.1.6
-----
Many small adjustments before first demo to internal DSG
0.1.7
-----
Changes to security settings for acces to JMX mBeans, this version is not ready for prod

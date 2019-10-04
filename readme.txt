AvailableNewMailboxSpace.ps1
	- change: 
		-> $customer = "%ExchangeMailDatabaseName%"
		-> $minDBfree = "2048" (min free space in MB)
			 
commands.conf
	- change:
		-> command = [ PluginContribDir + "/check_nrpe_size" ]   (path to check_nrpe_size, PluginContribDir = /usr/lib/nagios/plugins)

services.conf
	- change: 
		-> host_name = "%HOSTNAME%"	(hostname or ip)
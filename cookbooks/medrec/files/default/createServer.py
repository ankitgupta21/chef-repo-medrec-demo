import sys

hostname = sys.argv[1]
serverName = hostname + "server"

connect("weblogic","welcome1")
edit()
startEdit()
svr = cmo.createServer(serverName)
svr.setListenPort(8001)
svr.setListenAddress(hostname)
save()
activate(block="true")


# get the server mbean to target it
tBean = getMBean("Servers/managedServer")
if tBean != None:
    print "Found our target"
    sc.addTarget(tBean)
save()
activate(block="true")
disconnect()
exit()
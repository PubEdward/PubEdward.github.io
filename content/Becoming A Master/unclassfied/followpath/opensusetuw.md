
net-tools-deprecated - Deprecated Networking Utilities

This package contains the arp, ifconfig, netstat and route utilities, which have been replaced by tools from the iproute2 package: 
* arp -> ip [-r] neigh
* ifconfig -> ip a
* netstat -> ss [-r]
* route -> ip r
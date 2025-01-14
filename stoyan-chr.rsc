#stoyan-chr
# jan/14/2025 17:50:17 by RouterOS 6.49.13
# software id = 
#
#
#
/interface ethernet
set [ find default-name=ether1 ] disable-running-check=no
set [ find default-name=ether2 ] disable-running-check=no
set [ find default-name=ether1 ] disable-running-check=no name=ether3
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
/ip pool
add name=dhcp_pool0 ranges=192.168.10.20-192.168.10.220
/ip dhcp-server
add address-pool=dhcp_pool0 disabled=no interface=ether2 lease-time=3h name=dhcp1
/interface sstp-server server
set default-profile=default-encryption enabled=yes
/ip address
add address=172.21.106.50/24 interface=ether1 network=172.21.106.0
add address=192.168.10.254/24 interface=ether2 network=192.168.10.0
add address=172.21.108.60/24 interface=ether3 network=172.21.108.0
/ip dhcp-server lease
add address=192.168.10.220 client-id=1:0:50:56:96:89:52 comment=10.jan.25-ncs.install mac-address=00:50:56:96:89:52 server=dhcp1
add address=192.168.10.219 client-id=1:0:50:56:96:84:66 comment=10.jan.25-ncs.install mac-address=00:50:56:96:84:66 server=dhcp1
add address=192.168.10.218 client-id=1:0:50:56:96:ac:8e comment=10.jan.25-ncs.install mac-address=00:50:56:96:AC:8E server=dhcp1
add address=192.168.10.217 client-id=1:0:50:56:96:98:61 comment=10.jan.25-ncs.install mac-address=00:50:56:96:98:61 server=dhcp1
add address=192.168.10.216 client-id=1:0:50:56:96:cb:db comment=10.jan.25-ncs.install mac-address=00:50:56:96:CB:DB server=dhcp1
/ip dhcp-server network
add address=192.168.10.0/24 dns-server=192.168.10.254 gateway=192.168.10.254
/ip dns
set allow-remote-requests=yes servers=172.21.105.10
/ip dns static
add address=192.168.10.219 name=www.worksta-rhel9.com
add address=192.168.10.254 name=router.com
add address=192.168.10.217 comment=tenthOfJanuaryTwentyFiveNcsInstall name=ncs2
add address=192.168.10.216 comment=tenthOfJanuaryTwentyFiveNcsInstall name=ncs3
add address=192.168.10.218 comment=tenthOfJanuaryTwentyFiveNcsInstall name=ncs1
add address=192.168.10.220 comment=tenthOfJanuaryTwentyFiveNcsInstall name=dcib
/ip firewall nat
add action=masquerade chain=srcnat out-interface=ether1
add action=dst-nat chain=dstnat dst-port=2021 in-interface=ether1 protocol=tcp to-addresses=192.168.10.218 to-ports=22
/ip route
add distance=1 gateway=172.21.108.254
/ip service
set winbox port=8080
/ppp profile
add local-address=10.1.1.1 name=pppoe-profile remote-address=*2
/system identity
set name=stoyan-chr
/system logging
add topics=system,debug
add prefix=E topics=system,debug,account
[admin@stoyan-chr] > 
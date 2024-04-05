# Readme - Docker-Jenkins setup

1.  Install docker on host.

2.  Verify docker install.
	docker run hello-world

3.  Load Jenkins image to local docker repository.
	docker load -i jenkins_nexus_ng.tgz

4.  Execute Docker-Jenkins script
	bash run_dj.sh IMAGE NAME:TAG|ID

5.  Configure Jenkins pipeline script and agent nodes.

6.  Disable proxy CLI (temporarily), if using 'curl'
	unset http_proxy; unset https_proxy
	
7.  Disable proxy Browser
	Firefox | Chrome - Settings, No Proxy


#########################################
#####  Trouble-shooting + Security  #####
#########################################

# Confirm port listen
netstat -tuplen | grep LISTEN
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      0          23954      1/systemd           
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN      0          44272      2146/dnsmasq        
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          21336      1211/sshd           
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      0          40980      1216/cupsd          
tcp6       0      0 :::111                  :::*                    LISTEN      0          23956      1/systemd           
tcp6       0      0 :::50000                :::*                    LISTEN      1000       1888423    445434/java         
tcp6       0      0 :::8080                 :::*                    LISTEN      1000       1886315    445434/java         
tcp6       0      0 ::1:3350                :::*                    LISTEN      0          34654      1599/xrdp-sesman    
tcp6       0      0 :::22                   :::*                    LISTEN      0          21338      1211/sshd           
tcp6       0      0 ::1:631                 :::*                    LISTEN      0          40979      1216/cupsd          
tcp6       0      0 :::3389                 :::*                    LISTEN      0          44044      1601/xrdp           

# Network Mapper from Remote
nmap -Pn -n 10.165.134.84
Starting Nmap 7.92 ( https://nmap.org ) at 2024-04-04 16:24 CDT
Nmap scan report for 10.165.134.84
Host is up (0.0057s latency).
Not shown: 998 closed tcp ports (conn-refused)
PORT    STATE SERVICE
22/tcp  open  ssh
111/tcp open  rpcbind

# Disable SELinux
/etc/selinux/config
SELINUX=disabled

# Configure firewalld
firewall-cmd --list-all
public (active)
  target: default
  icmp-block-inversion: no
  interfaces: eno2
  sources: 
  services: cockpit dhcpv6-client http https ssh
  ports: 3389/tcp 3389/udp 8080/tcp 50000/tcp 443/tcp
  protocols: 
  forward: no
  masquerade: no
  forward-ports: 
  source-ports: 
  icmp-blocks: 
  rich rules: 

# Configure iptables
iptables -A INPUT -p tcp --dport 8080 -j ACCEPT
iptables --list | grep ACCEPT

Chain INPUT (policy ACCEPT)
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:webcache
Chain FORWARD (policy ACCEPT)
ACCEPT     all  --  anywhere             anywhere             ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             anywhere            
ACCEPT     all  --  anywhere             anywhere            
Chain OUTPUT (policy ACCEPT)
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootps
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootps
ACCEPT     udp  --  anywhere             anywhere             udp dpt:domain
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:domain
ACCEPT     udp  --  anywhere             anywhere             udp dpt:bootpc
ACCEPT     tcp  --  anywhere             anywhere             tcp dpt:bootpc
ACCEPT     all  --  192.168.122.0/24     anywhere            
ACCEPT     all  --  anywhere             192.168.122.0/24     ctstate RELATED,ESTABLISHED
ACCEPT     all  --  anywhere             anywhere            

iptables-save  # Optional - persist changes on reboot


#########################################
##############  Reference  ##############
#########################################

https://docs.docker.com/engine/install/centos/
https://docs.docker.com/engine/install/linux-postinstall/
https://www.jenkins.io/blog/2022/12/27/run-jenkins-agent-as-a-service/

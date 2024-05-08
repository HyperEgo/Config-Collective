# Readme - Jenkins Docker setup

1.  Install docker on host.
	bash install.sh

2.  Verify docker install - optional
	docker run hello-world

3.  Install and Configure Nexus Trust Certifications
	bash cert_cfg.sh

4.  Download Jenkins image.

5.  Load Jenkins image into local host Docker repository.
	docker load -i JENKINS_IMAGE

6.  Start Docker container w/ Jenkins image
	bash run.sh JENKINS_IMAGE

7.  Disable proxy via CLI (temporary terminal session) - optional
	unset http_proxy; unset https_proxy
	
8.  Disable proxy via OS and Browser
	Network Settings - ignore proxy HOST_IP | no proxy

9.  Verify Jenkins local install
	Browser URI => HOST_IP:8080

10. Configure Jenkins SCM checkout, pipeline script and agent nodes.
	Jenkins UI
__

#########################################
#####  Troubleshoot + Security cfg  #####
#########################################

# Confirm port listeners
netstat -tuplen | grep LISTEN
tcp        0      0 127.0.0.1:631           0.0.0.0:*               LISTEN      0          36133      1197/cupsd          
tcp        0      0 127.0.0.1:6010          0.0.0.0:*               LISTEN      1001       89382      12808/sshd: nguser@ 
tcp        0      0 0.0.0.0:111             0.0.0.0:*               LISTEN      0          17805      1/systemd           
tcp        0      0 192.168.122.1:53        0.0.0.0:*               LISTEN      0          45164      2158/dnsmasq        
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      0          39018      1207/sshd           
tcp6       0      0 ::1:631                 :::*                    LISTEN      0          36132      1197/cupsd          
tcp6       0      0 ::1:6010                :::*                    LISTEN      1001       89381      12808/sshd: nguser@ 
tcp6       0      0 :::3389                 :::*                    LISTEN      0          33420      1601/xrdp           
tcp6       0      0 :::111                  :::*                    LISTEN      0          17807      1/systemd           
tcp6       0      0 :::50000                :::*                    LISTEN      1000       111858     14369/java          
tcp6       0      0 :::8080                 :::*                    LISTEN      1000       110914     14369/java          
tcp6       0      0 ::1:3350                :::*                    LISTEN      0          35709      1599/xrdp-sesman    
tcp6       0      0 :::22                   :::*                    LISTEN      0          39020      1207/sshd           
__

# Network Mapper from Remote
nmap -Pn -n 10.165.134.12
Starting Nmap 6.40 ( http://nmap.org ) at 2024-04-23 17:19 CDT
Nmap scan report for 10.165.134.12
Host is up (0.91s latency).
Not shown: 993 filtered ports
PORT      STATE  SERVICE
22/tcp    open   ssh
80/tcp    closed http
443/tcp   closed https
3389/tcp  open   ms-wbt-server
8080/tcp  open   http-proxy
9090/tcp  closed zeus-admin
50000/tcp open   ibm-db2

Nmap done: 1 IP address (1 host up) scanned in 58.35 second
__

# Disable SELinux
/etc/selinux/config
SELINUX=disabled
__

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
__

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
__

#########################################
##############  Reference  ##############
#########################################

General setup and support
https://docs.docker.com/engine/install/centos/
https://docs.docker.com/engine/install/linux-postinstall/
https://www.jenkins.io/blog/2022/12/27/run-jenkins-agent-as-a-service/

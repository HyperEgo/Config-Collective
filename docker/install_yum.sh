#!/bin/bash

# yum install script, Fedora distros - test CentOS7

function printGraphic() {
	local gfx=""
	for i in $( seq $1 $2 )
	do
		gfx+="*"
	done
	echo -e "$gfx"
}

function printBanner() {
	local header=$1
	local tab='         '
	printGraphic 0 70
	echo -e "$tab$tab$tab$header"
	printGraphic 0 70
	echo -e "\n"
}

# file creation and declares
TSTAMP="$(date +%F_%R)"
LOG_PREV="/tmp/APPLOG_BEFORE.$TSTAMP.log"
REPO_LIST="/tmp/repo_list.$TSTAMP.log"
LOG_AFTER="/tmp/APPLOG_AFTER.$TSTAMP.log"

touch $LOG_PREV
touch $REPO_LIST
touch $LOG_AFTER

chmod 666 $LOG_PREV
chmod 666 $REPO_LIST
chmod 666 $LOG_AFTER

printBanner "Create APPLOG - BEFORE"
yum list installed >> $LOG_PREV
echo -e "\n$TSTAMP\n\n" >> $LOG_PREV
echo -e "\nAPPLOG - BEFORE: "$LOG_PREV"\n\n"

printBanner "Upgrade OS"
yum update && yum upgrade

printBanner "Install Network Utils"
#yum moo  # cow ascii art
yum install -y iputils-ping  # ping, tracert utilities
yum install -y cifs-utils  # SMB client for mounting
yum install -y netcat  # network analysis; e.g. nc -l <port number>
yum install -y nmap  # network scanner; e.g. nmap -v <dns | ip addr>
yum install -y wget  #  retrieve http, ftp files
yum install -y openssh-server
yum install -y nginx  # web server, reverse proxy, load balance, mail proxy, HTTP cache

printBanner "Install Text Editors, Picture Viewers"
yum install -y vim
yum install -y imagemagick  # image viewer, editor
yum install -y nano
yum install -y gedit
yum install -y eog  # image viewer

printBanner "Install xRDP"
yum install -y xrdp
#yum install -y xfce4
#echo -e xfce4-session > ~/.xsession
#echo -e "start xfce4" >> /etc/xrdp/startwm.sh
#cat /etc/xrdp/startwm.sh

printBanner "Install Browsers"
yum install -y firefox

# opera
#wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
#sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
#yum update; yum install -y opera

# google-chrome
#yum install -y libxss1 libappindicator1 libindicator7
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
#yum install -y -f; sudo dpkg -i google-chrome*.deb
#rm -rvf ./google-chrome*.deb  # remove archive file

printBanner "Create Repo Log"
grep . /etc/yum.repos.d/*.repo | grep 'http://' | sed 's/^.*\(http.*\).*$/\1/' >> $REPO_LIST
echo -e "\n$TSTAMP\n\n" >> $REPO_LIST
echo -e "\nRepo Log: "$REPO_LIST"\n\n"

printBanner "Create Install Log - AFTER"
yum list installed > $LOG_AFTER
echo -e "\n$TSTAMP\n\n" >> $LOG_AFTER
echo -e "\nApp Log - AFTER: "$LOG_AFTER"\n\n"


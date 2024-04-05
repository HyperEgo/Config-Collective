#!/bin/bash

# yum install - complete, full blown - Fedora distros

# functions
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

# vars
TSTAMP="$(date +%F_%R)"
LOGH=$HOME/tmp
mkdir -p $LOGH
LOGPV="$LOGH/LOG_prev.$TSTAMP.log"
REPO="r$LOGH/REPO_list.$TSTAMP.log"
LOGAF="$LOGH/LOG_after.$TSTAMP.log"

# file create, set
touch $LOGPV
touch $REPO
touch $LOGAF

chmod 755 $LOGPV
chmod 755 $REPO
chmod 755 $LOGAF

printBanner "LOG Previous"
yum list installed >> $LOGPV
echo -e "\n$TSTAMP\n\n" >> $LOGPV
echo -e "\nLOG Previous: "$LOGPV"\n\n"

printBanner "OS Upgrade"
yum update && yum upgrade

printBanner "Net Utils - install"
yum install -y iputils-ping
yum install -y cifs-utils  # SMB client, mounting
yum install -y netcat  # net analysis e.g. nc -l PORT
yum install -y nmap  # net scanner e.g. nmap -v DNS|IP
yum install -y wget  #  http, ftp files
yum install -y openssh-server
yum install -y nginx  # web server, reverse proxy, load balance, mail proxy, HTTP cache

printBanner "Editors Viewers - install"
yum install -y vim
yum install -y imagemagick
yum install -y nano
yum install -y gedit
yum install -y eog  # image viewer

printBanner "xRDP - install"
yum install -y xrdp
#yum install -y xfce4
#echo -e xfce4-session > ~/.xsession
#echo -e "start xfce4" >> /etc/xrdp/startwm.sh
#cat /etc/xrdp/startwm.sh

printBanner "Web Browser - install"
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

printBanner "LOG Repo"
grep . /etc/yum.repos.d/*.repo | grep 'http://' | sed 's/^.*\(http.*\).*$/\1/' >> $REPO
echo -e "\n$TSTAMP\n\n" >> $REPO
echo -e "\nRepo Log: "$REPO"\n\n"

printBanner "LOG After"
yum list installed > $LOGAF
echo -e "\n$TSTAMP\n\n" >> $LOGAF
echo -e "\nApp Log - AFTER: "$LOGAF"\n\n"

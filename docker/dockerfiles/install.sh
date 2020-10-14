#!/bin/bash

# starter installs for docker containers, ubuntu builds: 16.04, 14.04, 12.04

#set -x
printf "\n***********************************************************************************************\n"
printf "************************************  Create Install App Log - BEFORE  ************************\n"
printf "***********************************************************************************************\n"
INSTALL_LOG_PREV="/tmp/install_apps_BEFORE.$(date +%F_%R).log"
touch $INSTALL_LOG_PREV
chmod 666 $INSTALL_LOG_PREV
apt list --installed > $INSTALL_LOG_PREV
printf "\n$(date +%F_%R)\n\n" >> $INSTALL_LOG_PREV
printf "\nApp Log - BEFORE: "$INSTALL_LOG_PREV"\n\n"
printf "\n***********************************************************************************************\n"
printf "************************************  Upgrade OS  *********************************************\n"
printf "***********************************************************************************************\n"
apt-get update && apt-get upgrade  
printf "\n***********************************************************************************************\n"
printf "************************************  Install Network Utils  **********************************\n"
printf "***********************************************************************************************\n"
apt-get moo  # cow ascii art
apt-get install -y iputils-ping  # ping, tracert utilities
apt-get install -y cifs-utils  # SMB client for mounting
apt-get install -y netcat  # network analysis; e.g. nc -l <port number>
apt-get install -y nmap  # network scanner; e.g. nmap -v <dns | ip addr>
apt-get install -y wget  #  retrieve http, ftp files
apt-get install -y openssh-server  # ssh
apt-get install -y nginx  # web server, reverse proxy, load balance, mail proxy, HTTP cache
printf "\n***********************************************************************************************\n"
printf "************************************  Install Editors  ****************************************\n"
printf "***********************************************************************************************\n"
apt-get install -y vim  # install Linux default text editor VIM
apt-get install -y imagemagick  # view, convert, resize img from cmd line; e.g. display <image file>
apt-get install -y gimp  # graphic editor, convert, gif maker, etc.
apt-get install -y nano  # text editor
apt-get install -y gedit  # text editor
printf "\n***********************************************************************************************\n"
printf "************************************  Install xRDP  *******************************************\n"
printf "***********************************************************************************************\n"
apt-get install -y xrdp
apt-get install -y xfce4
echo xfce4-session > ~/.xsession
echo "start xfce4" >> /etc/xrdp/startwm.sh
#cat /etc/xrdp/startwm.sh
printf "\n***********************************************************************************************\n"
printf "************************************  Install Browsers  ****************************************\n"
printf "***********************************************************************************************\n"
apt-get install -y firefox  # firefox

# opera
wget -O - http://deb.opera.com/archive.key | sudo apt-key add -
sh -c 'echo "deb http://deb.opera.com/opera-stable/ stable non-free" >> /etc/apt/sources.list.d/opera.list'
apt-get update; apt-get install -y opera

# google-chrome
apt-get install -y libxss1 libappindicator1 libindicator7
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
apt-get install -y -f; sudo dpkg -i google-chrome*.deb
rm -rvf ./google-chrome*.deb  # remove archive file

printf "\n************************************************************************************************\n"
printf "************************************  Create Repo Log  *****************************************\n"
printf "************************************************************************************************\n"
REPO_LIST="/tmp/repo_list.$(date +%F_%R).log"
touch $REPO_LIST
chmod 666 $REPO_LIST
grep . /etc/apt/sources.list | grep 'http://' | sed 's/^.*\(http.*\).*$/\1/' > $REPO_LIST
printf "\n$(date +%F_%R)\n\n" >> $REPO_LIST
printf "\nRepo Log: "$REPO_LIST"\n\n"

printf "\n************************************************************************************************\n"
printf "***********************************  Create Install App Log - AFTER  ***************************\n"
printf "************************************************************************************************\n"
INSTALL_LOG_AFTER="/tmp/install_apps_AFTER.$(date +%F_%R).log"
touch $INSTALL_LOG_AFTER
chmod 666 $INSTALL_LOG_AFTER
apt list --installed > $INSTALL_LOG_AFTER
printf "\n$(date +%F_%R)\n\n" >> $INSTALL_LOG_AFTER
printf "\nApp Log - AFTER: "$INSTALL_LOG_AFTER"\n\n"


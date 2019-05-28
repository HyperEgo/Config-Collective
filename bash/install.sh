#!/bin/bash

# starter installs, ubuntu builds: 16.04, 14.04, 12.04

#set -x
printf "\n***********************************************************************************************\n"
printf "************************************  Create Install App Log - BEFORE  ************************\n"
printf "***********************************************************************************************\n"
install_before="/tmp/install_apps_BEFORE.$(date +%F_%R).log"
touch ${install_before}
chmod 666 ${install_before}
apt list --installed > ${install_before}
printf "\n$(date +%F_%R)\n\n" >> ${install_before}
printf "\nApp Log - BEFORE: "${install_before}"\n\n"
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
repos="/tmp/repo_list.$(date +%F_%R).log"
touch ${repos}
chmod 666 ${repos}
grep . /etc/apt/sources.list | grep 'http://' | sed 's/^.*\(http.*\).*$/\1/' > ${repos}
printf "\n$(date +%F_%R)\n\n" >> ${repos}
printf "\nRepo Log: "${repos}"\n\n"

printf "\n************************************************************************************************\n"
printf "***********************************  Create Install App Log - AFTER  ***************************\n"
printf "************************************************************************************************\n"
install_after="/tmp/install_apps_AFTER.$(date +%F_%R).log"
touch ${install_after}
chmod 666 ${install_after}
apt list --installed > ${install_after}
printf "\n$(date +%F_%R)\n\n" >> ${install_after}
printf "\nApp Log - AFTER: "${install_after}"\n\n"


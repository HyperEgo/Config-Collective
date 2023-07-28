#!/bin/bash

# print system diagnostics, environment variables, path pointers, bashrc, hd stats
# output: sys diag, bashrc, yum installed packages

# write input to stdout and file
function sendData() {
	echo -e "$1" 2>&1 | tee -a $2
}

# print table graphic
function printGraphic() {
	local gfx=""
	for i in $( seq $1 $2 )
	do
		gfx+="*"
	done
	sendData "$gfx" $3
}

# print table banner
function printBanner() {
	local header=$1
	local tab='         '
	sendData "\n" $2
	printGraphic 0 70 $2
	sendData "$tab$tab$tab$header" $2
	printGraphic 0 70 $2	
}

# main - process digital profile
function mainProcess() {
	local TSTAMP="$(date +%F_%R)"
	#local DEFAULT="/home/$USER/bkup-safe/sys-config"
	local DEFAULT="/tmp"
	local HEADER=""

	# check string const, create file header
	if [[ $1 == 'NOARG' ]] ; then
		HEADER=$DEFAULT
	elif [[ $1 == 'WORKING' ]] ; then
		HEADER="$(pwd)"
	elif [[ $1 == 'REMOTE' ]] ; then
		HEADER=$2
	else
		echo -e "\nFile location set error."
	fi

	local SYSDIAG="$HEADER/$(whoami)_$(hostname)_system-diag_$TSTAMP.log"
	local BASHRC="$HEADER/$(whoami)_$(hostname)_bashrc_$TSTAMP.log"
	local INSTALL="$HEADER/$(whoami)_$(hostname)_installed-packages-yum_$TSTAMP.log"

	touch $SYSDIAG
	touch $BASHRC
	touch $INSTALL

	chmod 755 $SYSDIAG
	chmod 755 $BASHRC
	chmod 755 $INSTALL

	printBanner "General Info" $SYSDIAG
	sendData "User: $(whoami)\n" $SYSDIAG
	sendData "OS: $(uname -a)\n" $SYSDIAG
	sendData "Logged-in: $(users)\n" $SYSDIAG
	sendData "Groups: $(whoami)\n" $SYSDIAG
	sendData "Date: $(date)\n" $SYSDIAG
	sendData "Uptime:$(uptime)" $SYSDIAG

	printBanner "Environment Vars" $SYSDIAG
	sendData "Unsorted PATH:\n$PATH\n" $SYSDIAG
	sortPath="$(sed 's/:/\n/g' <<< $PATH | sort)"
	sendData "Sorted PATH:\n$sortPath\n" $SYSDIAG
	sendData "SET Variables:\n$(/bin/bash -c 'set | sort')" $SYSDIAG

	printBanner "Software Metrics" $SYSDIAG
	sendData "Devices:\n$(lsblk -f | (sed -u 1q; sort) )\n" $SYSDIAG
	sendData "Usage:\n$(df -T -h | (sed -u 1q; sort) )\n" $SYSDIAG
	sendData "RAM:\n$(free -h)\n" $SYSDIAG
	sendData "Mount Points:\n$(mount | sort)" $SYSDIAG

	printBanner "Hardware Stats" $SYSDIAG
	sendData "CPU:\n$(lscpu)\n" $SYSDIAG
	#sendData "Block Device Attributes:\n$(blkid)\n" $SYSDIAG	# output empty on Ubuntu 16.x
	sendData "Block Device UUID:\n$(tree -F /dev/disk/by-uuid)\n" $SYSDIAG
	sendData "Block Device ID:\n$(tree -F /dev/disk/by-id)\n" $SYSDIAG
	sendData "X-Input Devices:\n$(xinput)\n" $SYSDIAG
	sendData "USB Devices:\n$(lsusb)\n" $SYSDIAG

	# write supplement files: bashrc, yum installed packages
	cat /home/$USER/.bashrc > $BASHRC
	#rpm -ql <<< rpm -qa | sort >> $INSTALL  	# RHEL 6.x yum installed packages
	dpkg --get-selections | sort > $INSTALL

	# notify user of output files and location
	echo -e "Output Files:\n$SYSDIAG\n$BASHRC\n$INSTALL\n"
}

# no arg - write default dir
if [[ $# -eq 0 ]] ; then
	mainProcess "NOARG"

# one arg - write input dir
elif [[ $# -eq 1 ]] && test -d $1 ; then
	if [[ $1 == '.' ]] ; then
		mainProcess "WORKING"
	else
		mainProcess "REMOTE" $1
	fi
else
	echo -e "\nBad file, directory or improper args."
fi

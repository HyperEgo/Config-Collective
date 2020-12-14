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
	TSTAMP="$(date +%F_%R).log"
	SYSDIAG="$1/$(whoami)_$(hostname)_system-diag_$TSTAMP"
	BASHRC="$1/$(whoami)_$(hostname)_bashrc_$TSTAMP"
	INSTALL="$1/$(whoami)_$(hostname)_installed-packages-yum_$TSTAMP"

	touch $SYSDIAG
	touch $BASHRC
	touch $INSTALL

	chmod 755 $SYSDIAG
	chmod 755 $BASHRC
	chmod 755 $INSTALL

	printBanner "General Info" $SYSDIAG
	sendData "User: $(whoami)\n" $SYSDAIG
	sendData "OS: $(uname -a)\n" $SYSDAIG
	sendData "Logged-in: $(users)\n" $SYSDAIG
	sendData "Groups: $(whoami)\n" $SYSDAIG
	sendData "Date: $(date)\n" $SYSDAIG
	sendData "Uptime: $(uptime)" $SYSDAIG

	printBanner "Environment Vars" $SYSDIAG
	sendData "Unsorted PATH:\n$PATH\n" $SYSDAIG
	sortPath="$(sed 's/:/\n/g' <<< $PATH | sort)"
	sendData "Sorted PATH:\n$sortPath\n" $SYSDAIG
	sendData "SET Variables:\n$(/bin/bash -c 'set | sort')" $SYSDAIG

	printBanner "Software Metrics" $SYSDIAG
	sendData "File System Devices:\n$(lsblk -f | sort)\n" $SYSDAIG
	sendData "File System Usage:\n$(df -T -h | sort)\n" $SYSDAIG
	sendData "RAM:\n$(free -h)\n" $SYSDAIG
	sendData "Mount Points:\n$(mount | sort)" $SYSDAIG

	printBanner "Hardware Stats" $SYSDIAG
	sendData "CPU Profile:\n$(lscpu)\n" $SYSDAIG
	#sendData "Block Device Attributes:\n$(blkid)\n" $SYSDAIG	# output empty on Ubuntu 16.x
	sendData "Block Device UUID:\n$(tree -F /dev/disk/by-uuid)\n" $SYSDAIG
	sendData "Block Device ID:\n$(tree -F /dev/disk/by-id)\n" $SYSDAIG
	sendData "X-Input Devices:\n$(xinput)\n" $SYSDAIG
	sendData "USB Devices:\n$(lsusb)" $SYSDAIG

	# write supplement files: bashrc, yum installed packages
	cat /home/$USER/.bashrc >> $BASHRC
	#rpm -ql <<< rpm -qa | sort >> $INSTALL  	# RHEL 6.x yum installed packages
	dpkg --get-selections | sort >> $INSTALL

	# notify user of output files and location
	echo -e "\nOutput Files:\n$SYSDIAG\n$BASHRC\n$INSTALL\n"
}

DEFAULT="/tmp"

# no arg - write to DEFAULT
if [[ $# -eq 0 ]] && test -d $DEFAULT ; then
	mainProcess $DEFAULT

# two args - write to current or custom directory
elif [[ $# -eq 1 ]] && test -d $1 ; then
	if [[ $1 == '.' ]] ; then
		mainProcess $(pwd)
	else
		mainProcess $1
	fi
else
	echo -e "\nBad file, directory or improper args."
fi


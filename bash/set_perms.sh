#!/bin/bash

# set directory permissions, recursive

# constants
PERMS=775
OWNER=ninjaboy

# process directory permissions
# arg $1 = owner, arg $2 = directory
function setPerms() {
	chown -R $1 $2
	chgrp -R $1 $2
	chmod -R $PERMS $2
}

# no arg - default owner, write curr dir
if [[ $# -eq 0 ]] ; then
	setPerms $OWNER $(pwd)

# one arg - input owner, write curr dir
elif [[ $# -eq 1 ]] ; then
	setPerms $1 $(pwd)

# two args - input owner, input write dir
elif [[ $# -eq 2 ]] && test -d $2 ; then

	# curr dir	
	if [[ $2 == '.' ]] ; then
		setPerms $1 $(pwd)

	# remote dir
	else
		setPerms $1 $2
	fi	
else
	echo -e "\nBad file, directory or improper args."
fi

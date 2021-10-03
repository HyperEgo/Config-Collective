#!/bin/bash

# copy, time stamp input file name

# constants
TSTAMP=$(date +%F_%R)

# check command error value condition, process input
# arg $1 = error value, arg $2 = input file
function checkError() {
	local errVal=$1
	local inFile=$2
	if [ $errVal -eq 0 ] ; then
		echo -e "\nStamped: $inFile"
	else
		echo -e "\nNot stamped!"
	fi
}

# one arg - input file, copy to same location as input
if [[ $# -eq 1 ]] && test -f $1 ; then
	FARG=$(basename $1)
	TFILE=$FARG\_$TSTAMP.stmp
	cp -air $FARG $TFILE
	checkError $? $TFILE

# two args - input file, input dir; copy file to input dir
elif [[ $# -eq 2 ]] && test -d $2 ; then
	FARG2=$1
	FPREP=$(basename $FARG2)\_$TSTAMP.stmp
	FDEST=$2\/$FPREP
	FDEST2=$(pwd)\/$FPREP

	# curr dir
	if [[ $2 == '.' ]] ; then
		cp -air $FARG2 $FDEST2
		checkError $? $FDEST2

	# remote dir
	else
		cp -air $FARG2 $FDEST
		checkError $? $FDEST
	fi
else
	echo -e "\nBad file or improper args."
fi

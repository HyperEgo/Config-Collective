#!/bin/bash

# copy, time stamp input file name

# check command error value condition, process input
function checkError() {
	local errVal=$1
	local inFile=$2
	if [ $errVal -eq 0 ] ; then
		echo -e "\nStamped: $inFile"
	else
		echo -e "\nNot stamped!"
	fi
}

TSTAMP=$(date +%F_%R).stmp

# one arg - input file only; copy file to same location as input
if [[ $# -eq 1 ]] && test -f $1 ; then
	FARG=$(basename $1)
	TFILE=$FARG\_$TSTAMP
	cp -air $FARG $TFILE
	checkError $? $TFILE

# two args - input file, input directory; copy file to directory
elif [[ $# -eq 2 ]] && test -d $2 ; then
	FARG2=$1
	FPREP=$(basename $FARG2)\_$TSTAMP
	FDEST=$2\/$FPREP
	FDEST2=$(pwd)\/$FPREP

	# current directory	
	if [[ $2 == '.' ]] ; then
		cp -air $FARG2 $FDEST2
		checkError $? $FDEST2

	# remote directory
	else
		cp -air $FARG2 $FDEST
		checkError $? $FDEST
	fi
else
	echo -e "\nBad file or improper args."
fi


#!/bin/bash

# devOps echo test script

# print contents to stdout, append time-stamp
function printOutput() {
	echo -e "\n$TSTAMP\n" >> $1
	cat $1
	echo -e "Echo log: $1\n"
}

# create file and time-stamp
TSTAMP="$(date +%F_%R)"
FILE="devops_echo_$TSTAMP.log"

touch $FILE
chmod 755 $FILE

# process graphic
cat > $FILE << eopts

Welcome to Development Operations !!

             _/                   _/_/_/
            _/                  _/     _/
       _/_/_/                  _/      _/
     _/   _/  _/_/_/ _/    _/ _/       _/  _/_/_/  _/_/_/
   _/    _/ _/    _/ _/   _/ _/       _/ _/    _/ _/
  _/    _/ _/_/_/_/  _/  _/  _/      _/ _/    _/ _/_/_/
  _/   _/ _/         _/ _/   _/     _/ _/    _/      _/
  _/_/_/   _/_/_/    _/_/     _/_/_/  _/_/_/_/  _/_/_/
                                     _/
                                    _/

eopts

DEFAULT="/tmp"
DEST=""

# no arg - write to DEFAULT
if [[ $# -eq 0 ]] ; then
	echo "test no arg"
	DEST="$DEFAULT/$FILE"
	cat $FILE > $DEST
	printOutput $DEST

# two args - write to current or custom directory
elif [[ $# -eq 1 ]] && test -d $1 ; then
	if [[ $1 == '.' ]] ; then
		echo "test working"
		DEST="$(pwd)/$FILE"
		printOutput $DEST
	else
		echo "test remote"
		DEST="$1/$FILE"
		cat $FILE > $DEST
		printOutput $DEST
	fi
else
	echo -e "\nBad file, directory or improper args."	
fi





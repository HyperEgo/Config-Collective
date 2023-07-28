#!/bin/bash

# devOps echo test script

# constants
DEFAULT="/tmp"
TSTAMP="$(date +%F_%R)"
FILE="$DEFAULT/devops_echo_$TSTAMP.log"

# process input file, append time stamp
function processFile() {
	echo -e "\n$TSTAMP\n" >> $1
	cat $1
	echo -e "Echo log: $1\n"
}

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

processFile $FILE

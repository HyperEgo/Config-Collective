#!/bin/bash

# devOps echo test script

# create file and time-stamp
TSTAMP="$(date +%F_%R)"
FILE="devops_echo_$TSTAMP.log"
DEST=$(pwd)\/$FILE

touch $DEST
chmod 755 $DEST

# process graphic
cat > $DEST << eopts

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

echo "$TSTAMP" >> $DEST
cat $DEST
echo -e "\nEcho log: $DEST\n"

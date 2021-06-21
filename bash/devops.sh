#!/bin/bash

# devOps echo test script

# print gfx and timestamp
function printGraphic() {
	echo -e "\n$TSTAMP\n" >> $1
	cat $1
	echo -e "Echo log: $1\n"
}

# const
DEFAULT="/tmp"
TSTAMP="$(date +%F_%R)"
FILE="$DEFAULT/devops_echo_$TSTAMP.log"

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

printGraphic $FILE


#!/bin/bash

# banner script

function printGraphic() {
	local gfx=""
	for i in $( seq $1 $2 )
	do
		gfx+="*"
	done
	echo -e "$gfx"
}

function printBanner() {
	local header=$1
	local tab='         '
	printGraphic 0 70
	echo -e "$tab$tab$tab$header"
	printGraphic 0 70
}

DEFAULT="TESTING 1 2 3 !!!"
if [[ $# -eq -0 ]] ; then
	echo -e "\n$DEFAULT\n"
elif [[ $# -eq 1 ]] ; then
	echo -e "\n$1\n"
else
	echo -e "\nBad input, file or improper args.\n"
fi




#!/bin/bash

# test script, output to stdout

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
echo -e "\n"
printBanner "TEST TEST TEST"
echo -e "\n"
printBanner "Another TEST TEST TESTees"
echo -e "\n"


#!/bin/bash

# time stamp input file

TIME_STAMP=$(date +%F_%R)
input=$1
if [ $# -eq 1 ] && test -f $input; then
	tfile=$input\_$TIME_STAMP.stamp
	cp -air $input $tfile  # preserve, interactive, recursive
	echo "File stamped: $tfile"
else
	echo "Bad file or improper number of args."
fi

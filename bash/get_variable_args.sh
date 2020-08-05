#!/bin/bash

# variable input arg example (no flags), for-loop echoes and counts selections
# input args space delimited

for i in $@  # accepts variable count input args
do
	echo $i
done
echo "There were $# arguments."  # totals number of input args


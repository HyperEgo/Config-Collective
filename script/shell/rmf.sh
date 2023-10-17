#!/bin/bash

# remove tmp files w/ char '~'

# no arg
if [[ $# -eq 0 ]] ; then

	find . -type f -iname "*~" -exec rm -rvf {} \;

# one arg
elif [[ $# -eq 1 ]] ; then

	find $1 -type f -iname "*~" -exec rm -rvf {} \;

else
	echo -e "\nBad file, directory or improper args."
fi


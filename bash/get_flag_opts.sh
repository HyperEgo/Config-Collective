#!/bin/bash

# getopts input example w/ cmd line args passed as flags (mandatory)
# e.g. ./<script> -a jblackwell -b Pa$$w0rd -c address -d phone

while getopts a:b:c:d: option; do
	case $option in
		a) user=$OPTARG ;;
		b) pass=$OPTARG ;;
		c) echo "Caught C-flag = $OPTARG";;
		d) echo "Caught D-flag = $OPTARG";;
	esac
done

echo -e "Username(A-Flag): $user \nPassword(B-Flag): $pass"

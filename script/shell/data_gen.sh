#!/bin/bash

# generate raw data

# arg 1 = output file
# arg 2 = run number
# arg 3 = pause time, sec

stamp="$(date +%F_%R)"
file_path=$(realpath $1)
out_file="${file_path}_${stamp}.raw"

RUNS=$2
PAUSE=$3

for i in $(seq 1 $RUNS); do mpstat -P ALL >> $out_file; sleep $PAUSE; done

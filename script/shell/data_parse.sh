#!/bin/bash

# parse .raw data files

# arg 1 = input file
# arg 2 = output directory

file_name=${1%%.*}
file_path=$(realpath $1)
dir_path=$(dirname $file_path)
out_dir=$2

out_file="$out_dir/${file_name}_parse.out"

inproc="$dir_path/.inprocess"

touch $out_file
touch $inproc
chmod -R 775 $out_file
chmod -R 775 $inproc

# debug
#echo -e "filename: $file_name\nfilepath: $file_path\ndirpath: $dir_path\noutfile: $out_file\n"

sed '/RUN/d' $file_path | sed '/Linux/d' > $inproc
awk '{print $1, $3, $13}' $inproc | column -t | sed 's/.*idle//g' | sed '1{/^ *$/d}' > $out_file
rm -f $inproc

echo -e "Generated file: $out_file\nRemoved file: $inproc\n"

#!/bin/bash

# diagnostic script - print hardware, software metrics

#set -ex
filename="/tmp/system-diag.$(date +%F_%R).log"
touch ${filename}
chmod 775 ${filename}
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  General Info  *******************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
whoami 2>&1 | tee -a ${filename}  # current username
uname -a 2>&1 | tee -a ${filename}  # os, system, kernel, machine id, etc.
date 2>&1 | tee -a ${filename}  # current date
uptime 2>&1 | tee -a ${filename}  # system uptime
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  Groups  *************************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
groups 2>&1 | tee -a ${filename}  # user affiliate group(s)
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  Hardware  ***********************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
lscpu 2>&1 | tee -a ${filename}  # cpu specs
printf "\n" 2>&1 | tee -a ${filename}
lsusb 2>&1 | tee -a ${filename}  # connected usb devices
printf "\n" 2>&1 | tee -a ${filename}
#lspci -m 2>&1 | tee -a ${filename}  # connected pci devices
xinput list 2>&1 | tee -a ${filename}  # connected pci | bus | non-usb devices
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  Disk Space  *********************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
lsblk 2>&1 | tee -a ${filename}  # hd capacity usage, tree diagram
printf "\n" 2>&1 | tee -a ${filename}
df -h 2>&1 | tee -a ${filename}  # file system capacity usage, listing
printf "\n" 2>&1 | tee -a ${filename}
pwd 2>&1 | tee -a ${filename}  # print working directory
du -cks -h * | sort -rn | head 2>&1 | tee -a ${filename}  # current working directory file usage
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  RAM  ****************************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
free -h 2>&1 | tee -a ${filename}  # RAM capacity usage
printf "\n***********************************************************************************************\n" 2>&1 | tee -a ${filename}
printf "************************************  Kernel Log  ***********************************************\n" 2>&1 | tee -a ${filename}
printf "***********************************************************************************************\n" 2>&1 | tee -a ${filename}
dmesg | tail -n10 2>&1 | tee -a ${filename}  # RAM, kernel, buffer log
printf "\n$(date +%F_%R)\n\n" >> ${filename}
printf "\nLog file: "${filename}"\n\n"

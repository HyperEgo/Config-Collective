#!/bin/bash

# diagnostic script - print hardware, software metrics

#set -ex
LOG_FILE="/tmp/system-diag.$(date +%F_%R).log"
touch $LOG_FILE
chmod 775 $LOG_FILE
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  General Info  *******************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
whoami 2>&1 | tee -a $LOG_FILE  # current username
uname -a 2>&1 | tee -a $LOG_FILE  # os, system, kernel, machine id, etc.
date 2>&1 | tee -a $LOG_FILE  # current date
uptime 2>&1 | tee -a $LOG_FILE  # system uptime
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  Groups  *************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
groups 2>&1 | tee -a $LOG_FILE  # user affiliate group(s)
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  Hardware  ***********************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
lscpu 2>&1 | tee -a $LOG_FILE  # cpu specs
printf "\n" 2>&1 | tee -a $LOG_FILE
lsusb 2>&1 | tee -a $LOG_FILE  # connected usb devices
printf "\n" 2>&1 | tee -a $LOG_FILE
#lspci -m 2>&1 | tee -a $LOG_FILE  # connected pci devices
xinput list 2>&1 | tee -a $LOG_FILE  # connected pci | bus | non-usb devices
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  Disk Space  *********************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
lsblk 2>&1 | tee -a $LOG_FILE  # hd capacity usage, tree diagram
printf "\n" 2>&1 | tee -a $LOG_FILE
df -h 2>&1 | tee -a $LOG_FILE  # file system capacity usage, listing
printf "\n" 2>&1 | tee -a $LOG_FILE
pwd 2>&1 | tee -a $LOG_FILE  # print working directory
du -cks -h * | sort -rn | head 2>&1 | tee -a $LOG_FILE  # current working directory file usage
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  RAM  ****************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
free -h 2>&1 | tee -a $LOG_FILE  # RAM capacity usage
printf "\n***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
printf "************************************  Kernel Log  ***********************************************\n" 2>&1 | tee -a $LOG_FILE
printf "***********************************************************************************************\n" 2>&1 | tee -a $LOG_FILE
dmesg | tail -n10 2>&1 | tee -a $LOG_FILE  # RAM, kernel, buffer log
printf "\n$(date +%F_%R)\n\n" >> $LOG_FILE
printf "\nLog file: "$LOG_FILE"\n\n"

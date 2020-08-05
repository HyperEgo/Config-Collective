#!/bin/bash

# Read user input during execution, save and echo results

read -p "What is your Username? " name  # prompt input same line
echo "What is your Password?"
read -s pass	# silent input while typing
read -p "What is your Security passphrase? " phrase
echo -e "\nCredential output below: \n usr = $name \n pswd = $pass \n phr = $phrase"

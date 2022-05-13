#!/bin/bash

# support script for terminal emulator - MobaXterm, Windows

# git clone cmd w/ integrated ssl
git -c http.sslVerify=false clone $1

#git config http.sslVerify false  # disable ssl
#git config credential.helper cache  # enable cred helper, MobaXterm errors

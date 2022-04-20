#!/bin/bash

# support script for GitHub|Lab terminal emulation - MobaXterm

# clone repo
git -c http.sslVerify=false clone $GIT_REPO

git config http.sslVerify false  # required for pushing changes
#git config credential.helper cache  # produces errors in MobaXterm

# optional - configure USER credentials
git config --global user.email $USER@$DOMAIN
git config --global user.name "$USER"

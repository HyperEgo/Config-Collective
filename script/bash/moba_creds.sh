#!/bin/bash

# auto set perms for MobaXterm

git config --global user.email "user@hostname"
git config --global user.name $USER

git config http.sslVerify "false"
git config credential.helper cache

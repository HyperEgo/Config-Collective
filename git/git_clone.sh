#!/bin/bash

# git clone support for win terminal emu e.g. MobaXterm

git -c http.sslVerify=false clone $1

#git config http.sslVerify false
#git config credential.helper cache

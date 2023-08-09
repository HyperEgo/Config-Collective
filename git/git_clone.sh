#!/bin/bash

# git clone support for terminal emu (MobaXterm) & stubborn repos

git config http.sslVerify false
git config credential.helper cache

git -c http.sslVerify=false clone $1

#!/bin/bash

# devOps echo script

filename="/tmp/devops.test.$(date +%F_%R).log"
touch ${filename}
cat > ${filename} << eopts

Why hello there, welcome to devOps!!

             _/                   _/_/_/
            _/                  _/     _/
       _/_/_/                  _/      _/
     _/   _/  _/_/_/ _/    _/ _/       _/  _/_/_/  _/_/_/
   _/    _/ _/    _/ _/   _/ _/       _/ _/    _/ _/
  _/    _/ _/_/_/_/  _/  _/  _/      _/ _/    _/ _/_/_/
  _/   _/ _/         _/ _/   _/     _/ _/    _/      _/
  _/_/_/   _/_/_/    _/_/     _/_/_/  _/_/_/_/  _/_/_/
                                     _/
                                    _/

eopts
printf "$(date +%F_%R)\n\n" >> ${filename}
printf "\nLog file: "${filename}"\n\n"

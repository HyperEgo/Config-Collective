# ~/.bashrc

# Source global definitions
if [[ -f /etc/bashrc ]] ; then
  . /etc/bashrc
fi

bind -s 'set completion-ignore-case on'  # ignore case, tab complete

# funct
function removeDupPath() {  # remove duplicates in $PATH
	local foo=$(sed 's/:/\n/g' <<< $PATH | sort | uniq -u)
	local fum=$(sed 's/:/\n/g' <<< $PATH | sort | uniq -d)
	local foo+=" $fum"
	PATH=$(echo $foo | sed 's/ /:/g')
}

# env
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH
export HISTTIMEFORMAT="%Y-%m-%d %T "  # time-date format for cmd history
export HISTCONTROL=ignoreboth  # ignore first space on writes to cmd history

# Prompt
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
magenta=$(tput setaf 5)
cyan=$(tput setaf 6)
white=$(tput setaf 7)
reset=$(tput sgr0)
bold=$(tput bold)

PS1='\[$bold\]\[$blue\]\u\[$white\]@\[$bold\]\[$cyan\]\h\[$reset\]> \[$red\]\W\[$reset\] \$ '

## Alias
alias duc='du -ch | sort -n'  # print space consumers w/ total
alias ll='ls -halF --color=auto'
alias hh='history'
alias naut='nautilus $(pwd)'

## Nav
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias bb='cd -'

# Git
alias gsh='git show --pretty --name-only $1'
alias gs='git status'
alias lgg='git log --graph --oneline --decorate --abbrev-commit --all'


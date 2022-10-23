# bashrc template - ~/.bashrc

bind -s 'set completion-ignore on'  # ignore case, tab complete

# Path - remove duplicates
function removeDupPath() {
	local foo=$(sed 's/:/\n/g' <<< $PATH | sort | uniq -u)
	local fum=$(sed 's/:/\n/g' <<< $PATH | sort | uniq -d)
	local foo+=" $fum"
	PATH=$(echo $foo | sed 's/ /:/g')
}

# Path
PATH="$HOME/bin:$HOME/.local/bin:$PATH"
export PATH

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
alias lgg='git log --graph --oneline --decorate --abbrev-commit --all'
alias gs='git status'

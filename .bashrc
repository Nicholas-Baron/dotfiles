#!/bin/bash

# Do nothing on non-interactive
case $- in
	*i*) ;;
	*) return;;
esac

set -o vi

export PS1=" \u@\H \A \w \$> "

alias ll="exa -l"
alias ls="exa"
alias la="exa -A"
alias lshere="ls --color=auto -gAFh --group-directories-first"
alias grep="grep --color=auto"
alias dir="dir --color=auto"
alias mycal="ncal -3Mbw"
alias mycalv="ncal -3Mw"
alias stop="sync && sync && sudo shutdown now"
alias restart="sync && sync && sudo shutdown -r now"
if [[ "$(uname -a)" =~ Ubuntu|Debian ]]; then
	alias update_check="sudo aptitude update && sudo aptitude --simulate upgrade -y"
	alias update_exec="sudo apt-fast upgrade -y"
fi
alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'

export VISUAL=/usr/bin/vim
export EDITOR=/usr/bin/vim

# append to history
shopt -s histappend

# Check window after every command
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

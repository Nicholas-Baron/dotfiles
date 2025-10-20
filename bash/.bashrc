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

export VISUAL=/usr/bin/nvim
export EDITOR=/usr/bin/nvim

alias gs='git status'
alias gap='git add -p'
alias gd='git diff'

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
. "$HOME/.cargo/env"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/nick/development/python/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/nick/development/python/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/nick/development/python/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/nick/development/python/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<


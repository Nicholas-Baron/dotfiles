
fish_vi_key_bindings

set -U EDITOR /usr/bin/nvim
set -U VISUAL /usr/bin/nvim

alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ls='exa'
alias mycal='cal -3mw'
alias mycalv='cal -3mwv'
alias cls='clear ; exa'
alias :q='exit'

# vim shortcuts
alias vim='nvim'
alias vimconf='nvim ~/.vimrc'
alias nvimconf='nvim ~/.config/nvim/init.vim'
alias fishconf='nvim ~/.config/fish/config.fish'

# git shortcuts
alias gs='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gd='git diff'
alias gds='git diff --staged'

abbr bash 'bash -i'
abbr run 'bash -ci'
abbr set_volume 'pactl set-sink-volume @DEFAULT_SINK@'
abbr toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
abbr cmake 'cmake -GNinja'
abbr update 'sudo aura -Syu ;and sudo aura -Au'
abbr stop "sync ;and sync ;and sudo shutdown now"
abbr restart "sync ;and sync ;and sudo shutdown -r now"
abbr goto 'cd (dirname (fzf))'

function mkcd --description 'make a directory and change into it'
    mkdir "$argv"
    cd "$argv"
end

function open --description 'always use xdg-open'
    xdg-open "$argv"
end

function fish_prompt --description 'Write out the prompt'
	set -l color_cwd
    set -l suffix
    switch "$USER"
        case root toor
            if set -q fish_color_cwd_root
                set color_cwd $fish_color_cwd_root
            else
                set color_cwd $fish_color_cwd
            end
            set suffix '#'
        case '*'
            set color_cwd $fish_color_cwd
            set suffix '>'
    end

    set time (date +"%R")
    echo -n -s "$time $USER" @ (prompt_hostname) ' ' (set_color $color_cwd) (prompt_pwd) (set_color normal) "$suffix "
end

function fish_right_prompt
    # Intentionally blank
end

# Startup code
if status --is-interactive
    and [ $TERM = "alacritty" ]
    printf "Now is %s\n\n" (date)
    mycalv
    echo
end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /home/nick/development/python/miniconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<


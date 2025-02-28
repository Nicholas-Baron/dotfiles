
fish_vi_key_bindings

set -Ux EDITOR /usr/bin/nvim
set -Ux VISUAL /usr/bin/nvim
set -Ux LESSCHARSET 'utf-8'

if test -r ~/.config/locale.conf

    grep 'export' ~/.config/locale.conf \
    | sed -E 's:export ([^=]+)=(.*)$:set -Ux \1 \2:' \
    | source

end

alias ls='exa'
alias la='exa -a'
alias lla='exa -la --git'
alias mycal='cal -3mw'
alias mycalv='cal -3mwv'
alias cls='clear ; exa'
alias :q='exit'
alias calc='qalc'
alias bindump='objdump -M intel --visualize-jumps -C'

# vim shortcuts
alias vim='nvim'
alias nvimconf='nvim ~/.config/nvim/init.lua'
alias fishconf='nvim ~/.config/fish/config.fish'
alias herbconf='nvim ~/.config/herbstluftwm/autostart'
alias swayconf='nvim ~/.config/sway/config'
alias barconf='nvim ~/.config/waybar/config.jsonc ~/.config/waybar/style.css -O'

# git shortcuts
alias gs='git status'
alias gap='git add -p'
alias gcm='git commit -m'
alias gd='git diff'
alias gds='git diff --staged'

abbr run 'bash -ci'
abbr set_volume 'pactl set-sink-volume @DEFAULT_SINK@'
abbr toggle_mute 'pactl set-sink-mute @DEFAULT_SINK@ toggle'
abbr cmake 'cmake -GNinja'
abbr update 'aura -Syu ;and aura -Au'
abbr weather "curl 'wttr.in/?M'"
abbr stop "sync ;and sync ;and sudo shutdown now"
abbr restart "sync ;and sync ;and sudo shutdown -r now"
abbr goto 'cd (dirname (fzf))'
abbr custom_grub 'env LANG=C sudo grub-customizer'

abbr dup 'alacritty --working-directory $PWD &; disown'

function terminal_size --description 'Set the alacritty terminal font size'
    alacritty msg config -w -1 font.size=$argv
end

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


set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin $PATH /home/nick/.ghcup/bin # ghcup-env

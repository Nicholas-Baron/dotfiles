
fish_vi_key_bindings

alias config='git --git-dir=$HOME/.dotfiles --work-tree=$HOME'
alias ls='exa'
alias mon2cam="deno run --unstable --allow-run --allow-read --allow-env -r -q https://raw.githubusercontent.com/ShayBox/Mon2Cam/master/src/mod.ts"
alias mycal='cal -3mw'

abbr bash 'bash -i'
abbr run 'bash -ci'

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

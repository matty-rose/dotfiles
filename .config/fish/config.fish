# Fish Stuff
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv yes
set -g theme_display_user ssh
set -g theme_display_host ssh
set -g theme_display_git_master_branch yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g theme_color_scheme solarized
set -g fish_prompt_pwd_dir_length 0
set -g theme_use_abbreviated_branch_names no
set -g theme_newline_cursor yes

set -e CONDA_SHLVL

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/matt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

set PATH /Users/matt/anaconda3/condabin:/Users/matt/anaconda3/bin $PATH

# Double virtual env in prompt
set -g VIRTUAL_ENV_DISABLE_PROMPT true

# Aliases
alias gst="git status"
alias gad="git add"
alias gch="git checkout"
alias gchb="git checkout -b"
alias gcm="git commit -m"
alias config="/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matt/google-cloud-sdk/path.fish.inc' ]; . '/Users/matt/google-cloud-sdk/path.fish.inc'; end

#kubectl krew
set -gx PATH $PATH $HOME/.krew/bin

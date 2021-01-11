# Start tmux
if status is-interactive
and not set -q TMUX
    exec TMUX
end

# Abbreviations
abbr -a e nvim
abbr -a gst "git status"
abbr -a gad "git add"
abbr -a gch "git checkout"
abbr -a gchb "git checkout -b"
abbr -a gcm "git commit -m"
abbr -a gcp "git cherry-pick"
abbr -a gpo "git pull origin"
abbr -a grc "git rebase --continue"
abbr -a grs "git rebase --skip"
abbr -a pa "source (poetry env info --path)/bin/activate.fish"
abbr -a cpom "config push origin master"
abbr -a vimdiff "nvim -d"

# Exa
if command -v exa > /dev/null
    abbr -a l 'exa'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l'
    abbr -a lll 'exa -la'
    abbr -a la 'exa -la'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Fish Stuff
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv yes
set -g theme_display_user ssh
set -g theme_display_host ssh
set -g theme_display_git_master_branch yes
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts no
set -g fish_prompt_pwd_dir_length 0
set -g theme_use_abbreviated_branch_names no
set -g theme_newline_cursor yes

set -e CONDA_SHLVL

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /Users/matt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

set PATH /Users/matt/anaconda3/condabin:/Users/matt/anaconda3/bin $PATH

# Stop brew autoupdating every install
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Double virtual env in prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT true

# Aliases
alias config="/usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matt/google-cloud-sdk/path.fish.inc' ]; . '/Users/matt/google-cloud-sdk/path.fish.inc'; end

#kubectl krew
set -gx PATH $PATH $HOME/.krew/bin

# Go
set -gx PATH $PATH $HOME/go/bin

# Set kubeeditor
set -gx KUBE_EDITOR /usr/local/bin/nvim

# Istioctl
set -gx PATH $PATH $HOME/.istioctl/bin

# No python bytecode
set -gx PYTHONDONTWRITEBYTECODE 1

function fish_greeting
	echo
	echo -e (uname -n | awk '{print " \\\\e[1mUser: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -ne (\
	    df -l -h | \
	    grep -E 'dev/disk1s1' |
	    awk '{print " \\\\e[1mDisk Usage:\\\\e[0m  "$4" Available\n  "$3"/"$2" Used\n  Capacity: "$5}'
	)
	echo
	echo
end

# Coloured man page
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

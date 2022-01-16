#================================================
#             ABBREVIATIONS/ALIASES
#================================================

# General Abbreviations
abbr -a e nvim
abbr -a ef "nvim (fzf-tmux -d 30% --reverse)"
abbr -a pa "source (poetry env info --path)/bin/activate.fish"
abbr -a vimdiff "nvim -d"
abbr -a poetry-bump "poetry show --no-dev -o -t | grep -v -e \"--\" | cut -d \" \" -f 1 | sed 's/\$/\@latest/g' | xargs poetry add"

# Git Abbreviations
abbr -a gst "git status"
abbr -a gad "git add"
abbr -a gch "git checkout"
abbr -a gchb "git checkout -b"
abbr -a gcm "git commit -s -m"
abbr -a gcp "git cherry-pick"
abbr -a gpo "git pull origin"
abbr -a grc "git rebase --continue"
abbr -a grs "git rebase --skip"
abbr -a gmt "git mergetool"
abbr -a gd "git diff"
abbr -a gcae "git commit --amend --no-edit"

# Dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
abbr -a cpom "config push origin main"
abbr -a ccm "config commit -s -m"
abbr -a ca "config add"
abbr -a cst "config status"
abbr -a cdiff "config diff"

# Exa
if command -v exa > /dev/null
    abbr -a l 'exa'
    abbr -a ls 'exa'
    abbr -a ll 'exa -l --git'
    abbr -a lll 'exa -la --git'
    abbr -a la 'exa -la --git'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

#================================================
#                     TMUX
#================================================

# Always run tmux when opening terminal
if status --is-interactive
# Don't nest tmux sessions
and not set -q TMUX
    # Create session called main or attach if it already exists
    tmux new-session -A -s main
end

#================================================
#             ENVIRONMENT VARIABLES
#================================================

# Add manually installed neovim
fish_add_path $HOME/.nvim/bin

# Fish Stuff
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv yes
set -g theme_display_user yes
set -g theme_display_host ssh
set -g theme_display_git_master_branch yes
set -g theme_display_k8s_context no
set -g theme_powerline_fonts yes
set -g theme_nerd_fonts yes
set -g fish_prompt_pwd_dir_length 0
set -g theme_use_abbreviated_branch_names no
set -g theme_newline_cursor yes
set -g theme_avoid_ambiguous_glyphs yes

# Stop brew autoupdating every install
set -gx HOMEBREW_NO_AUTO_UPDATE 1

# Double virtual env in prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT 1

#kubectl krew
fish_add_path $HOME/.krew/bin

# Go
fish_add_path $HOME/go/bin
fish_add_path -a /usr/local/go/bin

# Set kubeeditor
set -gx KUBE_EDITOR $HOME/.nvim/bin/nvim

# Istioctl
fish_add_path $HOME/.istioctl/bin

# No python bytecode
set -gx PYTHONDONTWRITEBYTECODE 1

# Good bash
fish_add_path /usr/local/Cellar/bash/5.1.4/bin

# Coloured man page
setenv LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
setenv LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
setenv LESS_TERMCAP_me \e'[0m'           # end mode
setenv LESS_TERMCAP_se \e'[0m'           # end standout-mode
setenv LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
setenv LESS_TERMCAP_ue \e'[0m'           # end underline
setenv LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

# kubectx plugin separator
set -gx KUBECTL_PROMPT_SEPARATOR "|"

# Rust
fish_add_path $HOME/.cargo/bin

# Haskell Language Server
fish_add_path $HOME/.haskell-language-server/bin

# Kubebuilder
fish_add_path /usr/local/kubebuilder/bin

# Pyenv
fish_add_path $HOME/.pyenv/bin

# Poetry
fish_add_path $HOME/.poetry/bin

# Default ripgrep command for fzf
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git"'

# JDK 8
fish_add_path /usr/local/opt/openjdk@8/bin

# .local bin
fish_add_path $HOME/.local/bin

# GHC
# set -q GHCUP_INSTALL_BASE_PREFIX[1]; or set GHCUP_INSTALL_BASE_PREFIX $HOME ; set -gx PATH $HOME/.cabal/bin /home/matt/.ghcup/bin $PATH # ghcup-env
fish_add_path $HOME/.cabal/bin
fish_add_path $HOME/.ghcup/bin

# Yarn
fish_add_path $HOME/.yarn/bin

# Protobuf Compiler
fish_add_path $HOME/.protobuf/bin

#================================================
#                     OTHER
#================================================

# Ruby version management
status --is-interactive; and source (rbenv init -|psub)

# Pyenv
status is-login; and pyenv init --path | source
pyenv init - | source

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/matt/google-cloud-sdk/path.fish.inc' ]; . '/Users/matt/google-cloud-sdk/path.fish.inc'; end

function fish_greeting
	echo
	echo -e (uname -n | awk '{print " \\\\e[1mUser: \\\\e[0;32m"$0"\\\\e[0m"}')
	echo -ne (\
	    df -l | \
	    grep -E 'dev/disk1s[123456] ' |
        awk '{ TOTAL = $2; USED += $3; AVAIL = $4; CAPACITY += $5 } END { print " \\\\e[1mDisk Usage:\\\\e[0m  "USED * 512 * 1e-9"Gi Available\n  "AVAIL * 512 * 1e-9"/"TOTAL * 512 * 1e-9"Gi Used\n  Capacity: "CAPACITY"%"}'
	)
	echo
	echo
end

function d
    while test $PWD != "/"
        if test -d .git
            break
        end
        cd ..
    end
end

# Direnv
direnv hook fish | source

# ASDF plugin
if test -e /usr/local/opt/asdf/asdf.fish
    source /usr/local/opt/asdf/asdf.fish
end

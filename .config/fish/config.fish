
#================================================
#                   M1 Brew
#================================================

eval "$(/opt/homebrew/bin/brew shellenv)"

#================================================
#                   Nix
#================================================

if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish' ]
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.fish'
end

#================================================
#             ABBREVIATIONS/ALIASES
#================================================

# General Abbreviations
abbr -a e nvim
abbr -a ef "nvim (fzf-tmux -d 30% --reverse)"
abbr -a pa "source (poetry env info --path)/bin/activate.fish"
abbr -a vimdiff "nvim -d"
abbr -a poetry-bump "poetry show --no-dev -o -t | grep -v -e \"--\" | cut -d \" \" -f 1 | sed 's/\$/\@latest/g' | xargs poetry add"
abbr -a nvim-startuptime 'rm /tmp/vim.log; nvim --startuptime /tmp/vim.log -c "quit" && cat /tmp/vim.log'
abbr -a k "kubectl"

# Git Abbreviations
abbr -a gst "git status"
abbr -a gad "git add"
abbr -a gch "git checkout"
abbr -a gchb "git checkout -b"
abbr -a gcm "git commit -S -m"
abbr -a gcp "git cherry-pick"
abbr -a gpo "git pull origin"
abbr -a grc "git rebase --continue"
abbr -a grs "git rebase --skip"
abbr -a gmt "git mergetool"
abbr -a gd "git diff"
abbr -a gds "git diff --staged"
abbr -a gcae "git commit --amend --no-edit"
abbr -a gpf "git push -f"
abbr -a gp "git pushu"
abbr -a ghpr 'git pushu && gh pr create -B master -a "@me" --fill-first | rg "https.*github.*" | xargs gh pr view --web'
abbr -a gfg "git fetch origin green:green"
abbr -a gfm "git fetch origin master:master"
abbr -a gsw "git branch | fzf --height=20% --reverse --info=inline | xargs git switch"
abbr -a gbd "git branch -D"
abbr -a gsc "git switch -c"

# Dotfiles
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME"
abbr -a cpom "config push origin main"
abbr -a ccm "config commit -S -m"
abbr -a ca "config add"
abbr -a cst "config status"
abbr -a cdiff "config diff"

# Eza
if command -v eza > /dev/null
    abbr -a l 'eza'
    abbr -a ls 'eza'
    abbr -a ll 'eza -l --git'
    abbr -a lll 'eza -la --git'
    abbr -a la 'eza -la'
    abbr -a lag 'eza -la --git'
else
    abbr -a l 'ls'
    abbr -a ll 'ls -l'
    abbr -a lll 'ls -la'
end

# Zoxide
if command -v zoxide > /dev/null
    abbr -a cd 'z'
end

# Bat
alias cat="bat"

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

set -gx GPG_TTY (tty)

# Add manually installed neovim
fish_add_path $HOME/.nvim/bin

# Fish Stuff
set -g theme_display_docker_machine yes
set -g theme_display_virtualenv yes
set -g theme_display_user yes
set -g theme_display_host ssh
set -g theme_display_git_master_branch yes
set -g theme_display_k8s_context yes
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
set -gx FZF_DEFAULT_COMMAND 'rg --files --hidden -g "!.git" -g "!bazel-bin/**" -g "!bazel-out/**" -g "!bazel-canva/**" -g "!bazel-testlogs/**"'

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

# JDTLS
fish_add_path $HOME/.local/jdtls/bin

# Starlark LS
fish_add_path $HOME/.starlark/bin

# Set brew on Linux vars
switch (uname)
    case Linux
        set -gx HOMEBREW_PREFIX "/home/linuxbrew/.linuxbrew";
        set -gx HOMEBREW_CELLAR "/home/linuxbrew/.linuxbrew/Cellar";
        set -gx HOMEBREW_REPOSITORY "/home/linuxbrew/.linuxbrew/Homebrew";
        set -q PATH; or set PATH ''; set -gx PATH "/home/linuxbrew/.linuxbrew/bin" "/home/linuxbrew/.linuxbrew/sbin" $PATH;
        set -q MANPATH; or set MANPATH ''; set -gx MANPATH "/home/linuxbrew/.linuxbrew/share/man" $MANPATH;
        set -q INFOPATH; or set INFOPATH ''; set -gx INFOPATH "/home/linuxbrew/.linuxbrew/share/info" $INFOPATH;
end

# Ripgrep config
set -gx RIPGREP_CONFIG_PATH $HOME/.config/ripgrep/.ripgreprc

fish_add_path /opt/homebrew/bin

fish_add_path $HOME/Library/Python/3.9/bin

fish_add_path "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

# Set editor
set -gx EDITOR nvim

#================================================
#                     OTHER
#================================================

# Ruby version management
status --is-interactive; and source (rbenv init -|psub)

# Pyenv WARNING: this stuff seems to slow down things fish a lot
# status is-login; and pyenv init --path | source
# pyenv init - | source
# if which pyenv-virtualenv-init > /dev/null
#     eval "$(pyenv virtualenv-init -)"
# end
# status --is-interactive; and pyenv virtualenv-init - | sed 's/--on-event fish_prompt/--on-variable PWD/g' | source

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

# 1password plugins
source ~/.config/op/plugins.sh

# Zoxide
zoxide init fish | source

# Starship
# starship init fish | source

# Tide
set --global tide_git_branch_truncation_length 50
set --global tide_git_icon 
set --global tide_left_prompt_items pwd git newline character
set --global tide_right_prompt_items status cmd_duration context jobs python rustc kubectl terraform aws nix_shell time

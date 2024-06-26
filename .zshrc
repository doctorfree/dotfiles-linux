#
## @file zshrc
## @brief Zsh .zshrc file with shell environment setup
## @author Ronald Joe Record (rr at ronrecord dot com)
## @copyright Copyright (c) 2012, Ronald Joe Record, all rights reserved.
## @date Written 17-Sep-2012
## @version 1.0.1
##

### Setup and Configuration # Begin
#
## Install ZSH
# Install with package manager on most platforms
# Use 'brew install zsh' on Mac OS to get version 5.9
# To get version 5.9 on Ubuntu 20.04 build from source:
#   download source release archive from
#     https://zsh.sourceforge.io/Arc/source.html
#   extract archive, ./configure; make; sudo make install
#   add /usr/local/bin/zsh to /etc/shells
#   change login shell with 'chsh -s /usr/local/bin/zsh'
#
## Install Oh My Zsh:
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
#
## Install Powerlevel10k theme for Oh My Zsh:
# git clone https://github.com/romkatv/powerlevel10k.git \
  #   $ZSH_CUSTOM/themes/powerlevel10k
#
## Set ZSH_THEME in $HOME/.zshrc
# ZSH_THEME="powerlevel10k/powerlevel10k"
#
## Install Zsh Plugins:
# git clone https://github.com/zsh-users/zsh-autosuggestions \
  #   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
  #   ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
# git clone https://github.com/zsh-users/zsh-completions \
  #   ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions
# git clone https://github.com/redxtech/zsh-kitty \
  #   ${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-kitty
#
## Install Meslo Nerd Font patched for Powerlevel10k
# See https://github.com/romkatv/powerlevel10k#fonts
# Configure terminal emulator, e.g. kitty.conf: 'font_family MesloLGS NF'
#
## Tab titles on Mac OS
# I needed to install the zsh-tab-title plugin to get Kitty tab titles right
#
#   git clone https://github.com/trystan2k/zsh-tab-title \
  #     ~/.oh-my-zsh/custom/plugins/zsh-tab-title
#
# Add zsh-tab-title into plugins array in .zshrc
# Add the following:
#   ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
#   ZSH_TAB_TITLE_ONLY_FOLDER=true
#
### Setup and Configuration # End

# If using GPG_TTY=$(tty) this needs to happen before p10k instant prompt
# as p10k instant prompt redirects stdin. Or, just use $TTY as that is a zsh
# environment variable available at all times regardless of stdin redirection
export GPG_TTY=$TTY

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
USE_STARSHIP=
if [ -f ${HOME}/.config/starship.toml ]
then
  USE_STARSHIP=1
else
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi
fi

umask 022

[ -d /usr/local/bin ] && PATH="/usr/local/bin:$PATH"
[ -d /usr/local/opt/curl/bin ] && PATH="/usr/local/opt/curl/bin:$PATH"
[ -d /usr/local/opt/libiconv/bin ] && PATH="/usr/local/opt/libiconv/bin:$PATH"
[ -d /opt/local/sbin ] && PATH="/opt/local/sbin:$PATH"
[ -d /opt/local/bin ] && PATH="/opt/local/bin:$PATH"
[ -d ~/bin ] && PATH=$PATH:~/bin
# To pickup GNU coreutils from the Brew installation path
[ -d /usr/local/opt/coreutils/libexec/gnubin ] && PATH=/usr/local/opt/coreutils/libexec/gnubin:$PATH

if [ `echo $PATH | grep -c /usr/local/sbin` -ne "1" ]; then
  PATH="$PATH:/usr/local/bin:/usr/local/sbin"
fi
if [ `echo $PATH | grep -c /usr/local/swift/bin` -ne "1" ]; then
  PATH="$PATH:/usr/local/swift/bin"
fi
if [ `echo $PATH | grep -c $HOME/bin` -ne "1" ]; then
  PATH="$PATH:$HOME/bin"
fi
if [ `echo $PATH | grep -c $HOME/.local/bin` -ne "1" ]; then
  PATH="$PATH:$HOME/.local/bin"
fi
if [ -d /usr/local/bunsen/bin ]; then
  PATH="$PATH:/usr/local/bunsen/bin"
fi
export PATH

[ -r .p4config ] && export P4CONFIG=.p4config
[ -d /build/toolchain ] && export TCROOT=/build/toolchain

[ -d $HOME/.rbenv/bin ] && export PATH="$HOME/.rbenv/bin:$PATH"
if command -v rbenv > /dev/null; then
  eval "$(rbenv init -)"
fi

# ConTeXt PATH
export PATH=$PATH:$HOME/context/tex/texmf-osx-64/bin

# The next line updates PATH for the Google Cloud SDK.
# if [ -f ~/Google/google-cloud-sdk/path.zsh.inc ]; then . ~/Google/google-cloud-sdk/path.zsh.inc; fi

# The next line enables shell command completion for gcloud.
# if [ -f ~/Google/google-cloud-sdk/completion.zsh.inc ]; then . ~/Google/google-cloud-sdk/completion.zsh.inc; fi

[ -d $HOME/.pyenv ] && export PYENV_ROOT="$HOME/.pyenv"
[ -d $HOME/.pyenv/bin ] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv > /dev/null; then
  eval "$(pyenv init --path)"
fi

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="robbyrussell"
[ "${USE_STARSHIP}" ] || ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
zstyle ':omz:update' frequency 14

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Highlighters to activate
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

typeset -A ZSH_HIGHLIGHT_STYLES
#
# Override main highlighter styles
#
# Differentiate aliases from other command types
ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta,bold'
# Have paths colored instead of underlined
ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
# Disable highlighting of globbing expressions
ZSH_HIGHLIGHT_STYLES[globbing]='none'
#
# Override brackets highlighter styles
#
# Define styles for nested brackets up to level 4
ZSH_HIGHLIGHT_STYLES[bracket-level-1]='fg=blue,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-2]='fg=red,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-3]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[bracket-level-4]='fg=magenta,bold'

# MAGIC_ENTER_GIT_COMMAND='git status -u .'
# MAGIC_ENTER_OTHER_COMMAND='ls -lh .'
MAGIC_ENTER_GIT_COMMAND='git status'
MAGIC_ENTER_OTHER_COMMAND='ls'

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
#
# Not used but useful: common-aliases, fzf, themes
# Available plugins: https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins
plugins=(
  fzf-tab
  magic-enter
  zsh-autosuggestions
  zsh-kitty
  zsh-syntax-highlighting
  web-search
)

# To enable the flatpak plugin
# plugins+=(flatpak)

# Check if git, gh, and thefuck are available
if command -v gh > /dev/null; then
  plugins+=(gh)
fi
if command -v git > /dev/null; then
  plugins+=(git)
fi
if command -v thefuck > /dev/null; then
  plugins+=(thefuck)
fi

# What OS are we running?
if [[ `uname` == "Darwin" ]]; then
  plugins+=(macos zsh-tab-title)
  ZSH_TAB_TITLE_DEFAULT_DISABLE_PREFIX=true
  ZSH_TAB_TITLE_ONLY_FOLDER=true
  if command -v brew > /dev/null; then
    HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
    [ -f "$HB_CNF_HANDLER" ] && {
      source "$HB_CNF_HANDLER"
      plugins+=(command-not-found)
    }
    plugins+=(brew)
  fi
  if command -v port > /dev/null; then
    plugins+=(macports)
  fi
elif command -v apt > /dev/null; then
  plugins+=(debian command-not-found)
elif command -v pacman > /dev/null; then
  plugins+=(archlinux command-not-found)
elif command -v dnf > /dev/null; then
  plugins+=(dnf command-not-found)
fi

# Do we have systemd on board?
if command -v systemctl > /dev/null; then
  plugins+=(systemd)
fi

# Ditto Kubernetes?
if command -v kubectl > /dev/null; then
  plugins+=(kubectl)
fi

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

# Proper autocompletions
autoload -U compinit && compinit

source $ZSH/oh-my-zsh.sh

__kitty_complete

# User configuration

export MANPATH="/usr/local/share/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi
export VISUAL=vim
export EDITOR=${VISUAL}

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# If you are running through a proxy service some external programs may need
# to know the proxy setting (e.g. gem). If so, configure and uncomment:
# export http_proxy=http://proxy.vmware.com:3128
# export no_proxy=wallhaven.cc

export GOOGLE_APPLICATION_CREDENTIALS=$HOME/Keys/Text-to-Speech-d00ec3799688.json
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias dir='dir --color=auto'
  alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
else
  export CLICOLOR=1
  export LSCOLORS=DxFxcxdxCxegedabagacad
  alias ls='/bin/ls -G'
fi

if command -v zoxide > /dev/null; then
  eval "$(zoxide init zsh)"
fi

[ -f ~/.ghcup/env ] && source ~/.ghcup/env

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

[ -f ~/.functions ] && source ~/.functions

[ -f ~/.private ] && source ~/.private

[ -f ~/.kitty_keys ] && source ~/.kitty_keys

function _kitty_keys {
  compadd 'copypaste' 'debugging' 'layouts' 'miscellaneous' 'scrolling' 'tabs' 'windows' 'custom'
}
compdef _kitty_keys kitty_keys

# GPU Mining parameters
export GPU_MAX_ALLOC_PERCENT=100
export GPU_MAX_HEAP_SIZE=100
export GPU_SINGLE_ALLOC_PERCENT=100
export GPU_USE_SYNC_OBJECTS=1
export GPU_FORCE_64BIT_PTR=1
export CUDA_DEVICE_ORDER=PCI_BUS_ID

export KDE_FULL_SESSION=false
export IPFS_PATH=/etc/ipfs

# enable terminal linewrap
setterm -linewrap on 2> /dev/null

# colorize man pages
man () {
  LESS_TERMCAP_mb=$'\e[01;31m' \
    LESS_TERMCAP_md=$'\e[01;35m' \
    LESS_TERMCAP_me=$'\e[0m' \
    LESS_TERMCAP_se=$'\e[0m' \
    LESS_TERMCAP_so=$'\e[01;33m' \
    LESS_TERMCAP_ue=$'\e[0m' \
    LESS_TERMCAP_us=$'\e[04;36m' \
    command man "$@"
}
# Using tput with green and cyan, yellow on blue, white
# Color       #define       Value       RGB
# black     COLOR_BLACK       0     0, 0, 0
# red       COLOR_RED         1     max,0,0
# green     COLOR_GREEN       2     0,max,0
# yellow    COLOR_YELLOW      3     max,max,0
# blue      COLOR_BLUE        4     0,0,max
# magenta   COLOR_MAGENTA     5     max,0,max
# cyan      COLOR_CYAN        6     0,max,max
# white     COLOR_WHITE       7     max,max,max
#
#   LESS_TERMCAP_mb=$(tput bold; tput setaf 2) \
#   LESS_TERMCAP_ZN=$(tput ssubm) \
#   LESS_TERMCAP_ZV=$(tput rsubm) \
#   LESS_TERMCAP_ZO=$(tput ssupm) \
#   LESS_TERMCAP_ZW=$(tput rsupm) \
#man () {
#    LESS_TERMCAP_md=$(tput bold; tput setaf 6) \
#    LESS_TERMCAP_me=$(tput sgr0) \
#    LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 57) \
#    LESS_TERMCAP_se=$(tput rmso; tput sgr0) \
#    LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 4) \
#    LESS_TERMCAP_ue=$(tput rmul; tput sgr0) \
#    LESS_TERMCAP_mr=$(tput rev) \
#    LESS_TERMCAP_mh=$(tput dim) \
#    command man "$@"
#}

export LESSHISTFILE=-

# Set the location of the bat config file
export BAT_CONFIG_PATH="/etc/bat.conf"

# see /usr/share/doc/bash/examples/startup-files
# (in the package bash-doc) for examples

# MEDIAROOT is used by doctorfree's Scripts to identify the media root
export MEDIAROOT=/u

#export BROWSER=firefox
export FX_THEME=9

[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# Created by `pipx` on 2022-10-01 18:44:33
export PATH="$PATH:/home/ronnie/.local/bin"

# Don't merge histories from all tabs
unsetopt inc_append_history
unsetopt share_history

# Are we using Powerlevel10k or Starship prompt
if [ "${USE_STARSHIP}" ]
then
  if command -v starship > /dev/null
  then
    eval "$(starship init zsh)"
  else
    [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
  fi
else
  # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
fi

PATH="/home/ronnie/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/ronnie/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/ronnie/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/ronnie/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/ronnie/perl5"; export PERL_MM_OPT;

# Go paths
# [ -d /usr/lib/go-1.13 ] && export GOROOT=/usr/lib/go-1.13
# [ -d $HOME/go ] && export GOPATH=$HOME/go
[ -d ${HOME}/go/bin ] && PATH=$PATH:${HOME}/go/bin
[ -d /usr/local/go/bin ] && PATH=$PATH:/usr/local/go/bin
export PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export GEM_HOME="$HOME/gems"
export PATH="$PATH:$HOME/gems/bin"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#
# Set aliases after all PATH components have been added
[ -f ~/.aliases ] && source ~/.aliases

export TZ="America/Los_Angeles"
# Source the Lazyman shell initialization for aliases and nvims selector
# shellcheck source=.config/nvim-Lazyman/.lazymanrc
[ -f ~/.config/nvim-Lazyman/.lazymanrc ] && source ~/.config/nvim-Lazyman/.lazymanrc
# Source the Lazyman .nvimsbind for nvims key binding
# shellcheck source=.config/nvim-Lazyman/.nvimsbind
[ -f ~/.config/nvim-Lazyman/.nvimsbind ] && source ~/.config/nvim-Lazyman/.nvimsbind
# Bob neovim version manager path
[ -d ${HOME}/.local/share/bob/nvim-bin ] && {
  export PATH="${HOME}/.local/share/bob/nvim-bin${PATH:+:${PATH}}"
}
# Luarocks bin path
[ -d ${HOME}/.luarocks/bin ] && {
  export PATH="${HOME}/.luarocks/bin${PATH:+:${PATH}}"
}

# bun completions
[ -s "/home/ronnie/.bun/_bun" ] && source "/home/ronnie/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -f ~/.fzf-functions.zsh ] && source ~/.fzf-functions.zsh

export PATH=$HOME/bin:$PATH
# Added by PMD
export PATH="$PATH:$HOME/.local/share/pmd-bin-7.1.0/bin"
source <(pmd generate-completion)

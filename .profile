# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
  # include .bashrc if it exists
  if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
  fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ]; then
  PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ]; then
  PATH="$HOME/.local/bin:$PATH"
fi

if [ -e /home/ronnie/.nix-profile/etc/profile.d/nix.sh ]; then . /home/ronnie/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer

# Created by `pipx` on 2022-10-01 18:44:33
PATH="$PATH:/home/ronnie/.local/bin"

# Go paths
# [ -d /usr/local/go ] && export GOROOT=/usr/local/go
# [ -d $HOME/go ] && export GOPATH=$HOME/go
[ -d /usr/local/go/bin ] && PATH=$PATH:/usr/local/go/bin
export PATH
. "$HOME/.cargo/env"

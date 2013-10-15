#!/usr/bin/env sh
# Figure out where the actual dotfiles dir is:
SCRIPT=$(readlink -f "$0")
DOTDIR=$(dirname "$SCRIPT")
# cp files needed on most installs to $HOME
cp -bfr $DOTDIR/{.zshrc,.zsh,.vimrc,.vim,.vimpagerrc} $HOME

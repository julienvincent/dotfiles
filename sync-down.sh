#!/usr/bin/env bash

set -eo pipefail

cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp .vimrc ~/.vimrc # To install plugins, run :PlugInstall
cp .karabiner.json ~/.config/karabiner/karabiner.json
cp .gitconfig ~/.gitconfig

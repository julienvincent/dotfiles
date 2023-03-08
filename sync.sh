#!/usr/bin/env bash

set -eo pipefail

cp ~/.zshrc .zshrc
cp ~/.vimrc .vimrc
cp ~/.gitconfig .gitconfig

mkdir -p .config/lsd
mkdir -p .config/karabiner

cp ~/.config/starship.toml .config/starship.toml
cp ~/.config/lsd/config.yaml .config/lsd/config.yaml
cp ~/.config/karabiner/karabiner.json .config/karabiner/karabiner.json

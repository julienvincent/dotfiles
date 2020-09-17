#!/usr/bin/env bash

# General tooling
brew install fzf
brew install bat
brew install htop
brew install tldr

# Docker tools
brew tap wagoodman/dive
brew install dive

# Kubernetes tools
brew install kubectx
brew install stern

# Git diff niceties
brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"
git config --bool --global diff-so-fancy.stripLeadingSymbols false

curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
chmod +x prettyping
mv prettyping /usr/local/bin/pping

cp .zshrc ~/.zshrc

# To install plugins, run :PlugInstall
cp .vimrc ~/.vimrc

$(brew --prefix)/opt/fzf/install

echo "vscode gist: 64169414cea291041e10a00fc1abc430"

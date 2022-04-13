#!/usr/bin/env bash

set -eo pipefail

# General tooling
brew install fzf
brew install ngrok
brew install zsh
brew install fnm
brew install rbenv
brew install jq
brew install bat
brew install git-delta
brew install dog

# Docker tools
brew install docker-credential-helper-ecr

# Kubernetes tools
brew install kubectl
brew install kubectx
brew install stern

# AWS
brew install awscli

# Git diff niceties
brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"
git config --bool --global diff-so-fancy.stripLeadingSymbols false

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# Install Powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

./sync-down.sh

$(brew --prefix)/opt/fzf/install

echo "vscode gist: 64169414cea291041e10a00fc1abc430"

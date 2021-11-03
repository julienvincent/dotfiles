#!/usr/bin/env bash

set -eo pipefail

# General tooling
brew install fzf
brew install bat
brew install htop
brew install tldr
brew install ngrok
brew install zsh
brew install fnm

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

# Install prettyping
curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
chmod +x prettyping
mv prettyping /usr/local/bin/pping

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

cp .zshrc ~/.zshrc
cp .p10k.zsh ~/.p10k.zsh
cp .vimrc ~/.vimrc # To install plugins, run :PlugInstall

$(brew --prefix)/opt/fzf/install

echo "vscode gist: 64169414cea291041e10a00fc1abc430"

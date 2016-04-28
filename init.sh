#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

# make some common directories
mkdir code

# brew installs
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
sh brew.sh

# zsh install
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
chsh -s /usr/local/bin/zsh

sh bootstrap.sh

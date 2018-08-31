#!/usr/bin/env bash

brew install fzf
brew install bat
brew install htop
brew install tldr

brew install diff-so-fancy
git config --global core.pager "diff-so-fancy | less --tabs=2 -RFX"
git config --bool --global diff-so-fancy.stripLeadingSymbols false

curl -O https://raw.githubusercontent.com/denilsonsa/prettyping/master/prettyping
chmod +x prettyping
mv prettyping /usr/local/bin/pping

cp .zshrc ~/.zshrc

echo "vscode gist: 64169414cea291041e10a00fc1abc430"

#!/usr/bin/env bash


# Ask for the administrator password upfront and extend 'sudo' expiry
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

brew install wget
brew install git
brew install docker-compose
brew install docker
brew install node
brew install zsh

brew cleanup
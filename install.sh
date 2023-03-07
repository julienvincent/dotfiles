#!/usr/bin/env bash

set -eo pipefail

brew install \
  diff-so-fancy \
  pulumi \
  watch \
  lsd \
  awscli \
  docker-credential-helper-ecr \
  helm \
  babashka \
  hey \
  iperf3 \
  starship \
  stern \
  jq \
  zsh \
  fzf \
  just \
  restic \
  kafkactl \
  ripgrep \
  tig \
  git \
  kubectx \
  rsync \
  velero \
  ngrok

# Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./sync-down.sh

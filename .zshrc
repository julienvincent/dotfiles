export ZSH="/Users/julienvincent/.oh-my-zsh"

ENABLE_CORRECTION="false"
MODE_INDICATOR=

plugins=(git zsh-vim-mode)

source $ZSH/oh-my-zsh.sh

# ----- SETTINGS ----- #

export EDITOR=vim

# == vi-mode plugin ==

# makes pressing esc instant, might introduce other side-effects - not sure
export KEYTIMEOUT=1

# == JourneyApps ==

# Configured the journey-formatter precommit hook to automatically format and git add files when committing
export JOURNEY_FORMATTER_AUTO_FORMAT=1
export AWS_VAULT_KEYCHAIN_NAME=login

# == FZF ==
export FZF_DEFAULT_COMMAND="rg --files --hidden --glob=\!.git"

_fzf_compgen_path() {
  rg --files --hidden --glob=\!.git . "$1"
}

_fzf_compgen_dir() {
  rg --hidden --files --glob=\!.git --null . "$1" | xargs -0 dirname | uniq
}

# ----- FUNCTIONS ----- #

sternc () {
  stern "${@}" -o raw | grep --line-buffered '^{"' --color=never
}

flush-dns () {
  sudo dscacheutil -flushcache;
  sudo killall -HUP mDNSResponder
}

# delete local git branches no longer present on the remote
git-prune-branches () {
  git remote prune origin

  git branch --merged | sed  's/\*.*//' > \
    /tmp/merged-branches && \
    vim /tmp/merged-branches && \
  xargs git branch -d < /tmp/merged-branches
}

# Find processes by their bound ports
pid-by-port () {
  sudo lsof -i -n -P | grep TCP | grep $1
}

prenv () {
  env $(cat .env) "${@}"
}

grepf() {
  fzf --no-sort --filter "${@}"
}

nclean() {
  rm -r **/node_modules || true
  rm -r **/dist || true
  rm **/*.tsbuildinfo || true
}

nfclean() {
  nclean && rm pnpm-lock.yaml
}

k() {
  kubectl "${@}"
}
p() {
  pnpm "${@}"
}

# Function to shorten keypresses for authenticating a command with
# aws iam
#
# > iam root kubectl get pods
# =
# > aws-vault exec root -- kubectl get pods
iam () {
  aws-vault exec "${1}" -- "${@:2}"
}

# ----- AUTO-COMPLETION ----- #

source <(kubectl completion zsh)
source <(stern --completion=zsh)

# ----- ALIASES ----- #

alias p="pnpm"
alias pl="pnpm link --global"
alias px="pnpx"

alias k="kubectl"
alias ka="kafkactl"

alias ls="lsd"

alias wo="webstorm ."
alias rmo="rubymine ."
alias co="code --add ."

alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-on="defaults write -g ApplePressAndHoldEnabled -bool true"

alias iams="iam kubernetes-staging"
alias iamp="iam kubernetes-production"

alias fscan="du -hs * | sort -rh | head -10"

# ----- EXPORTS ----- #

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/gcloud/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

eval "$(fnm env)"
eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PNPM_HOME="/Users/julienvincent/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# bun
[ -s "/Users/julienvincent/.bun/_bun" ] && source "/Users/julienvincent/.bun/_bun"

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# starship
eval "$(starship init zsh)"

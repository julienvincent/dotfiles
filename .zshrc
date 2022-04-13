# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/Users/julienvincent/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"
ENABLE_CORRECTION="false"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# ----- SETTINGS ----- #

# Enable VIM
#set keyseq-timeout 0
#set -o vi

# ----- FUNCTIONS ----- #

sternc () {
  stern "${@}" -o raw | grep --line-buffered '^{"' --color=never
}

# delete local git branches no longer present on the remote
pruneGitBranches () {
  git remote prune origin

  git branch --merged | sed  's/\*.*//' > \
    /tmp/merged-branches && \
    vim /tmp/merged-branches && \
  xargs git branch -d < /tmp/merged-branches
}

prenv () {
  env $(cat .env) "${@}"
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

# alias wo="webstorm ."
alias rmo="rubymine ."
alias co="code --add ."

alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-on="defaults write -g ApplePressAndHoldEnabled -bool true"

alias iams="iam kubernetes-staging"
alias iamp="iam kubernetes-production"

alias git-prune-branches="pruneGitBranches"
alias fscan="du -hs * | sort -rh | head -10"

# ----- EXPORTS ----- #

export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/gcloud/bin:$PATH"

export EDITOR=vim
export AWS_VAULT_KEYCHAIN_NAME=login

# Configured the journey-formatter precommit hook to automatically format and git add files when committing
export JOURNEY_FORMATTER_AUTO_FORMAT=1

export PULUMI_K8S_SUPPRESS_HELM_HOOK_WARNINGS=true

# ----- AUTO ----- #

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval "$(fnm env)"
eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


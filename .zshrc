export ZSH=/Users/julienvincent/.oh-my-zsh

fpath=( "$HOME/.dotfiles/.zsh-custom/functions" $fpath )

ZSH_THEME=""
ENABLE_CORRECTION="false"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
)

source ${ZSH}/oh-my-zsh.sh

# pure prompt theme
autoload -U promptinit; promptinit
prompt pure

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
alias px="pnpx"
alias k="kubectl"

# alias wo="webstorm ."
alias rmo="rubymine ."
alias co="code --add ."

alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-on="defaults write -g ApplePressAndHoldEnabled -bool true"

alias dcup="docker-compose up"

alias iams="iam kubernetes-staging"
alias iamp="iam kubernetes-production"

alias git-prune-branches="pruneGitBranches"
alias fscan="du -hs * | sort -rh | head -10"

alias pushup="git push -u origin HEAD"
alias set-upstream="git branch --set-upstream-to=origin/`git branch --show-current`"

# ----- EXPORTS ----- #

export EDITOR=vim
export ANDROID_HOME=/Users/julienvincent/Library/Android/sdk
export AWS_VAULT_KEYCHAIN_NAME=login
export RBENV_ROOT="/usr/local/var/rbenv"
export PATH=$PATH:$(go env GOPATH)/bin

# Configured the journey-formatter precommit hook to automatically format and git add files when committing
export JOURNEY_FORMATTER_AUTO_FORMAT=1

export PULUMI_K8S_SUPPRESS_HELM_HOOK_WARNINGS=true

# ----- AUTO ----- #

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/julienvincent/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/julienvincent/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/julienvincent/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/julienvincent/google-cloud-sdk/completion.zsh.inc'; fi

. "$HOME/.cargo/env"


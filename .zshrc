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

# ----- FUNCTIONS ----- #

sternToJQ () {
  PARSER='.message'

  if [[ "${2}" != ""  ]]; then {
    PARSER=${2}
  }
  fi

  stern ${1} -o raw |\
  grep --line-buffered '^{"' --color=never |\
  jq --unbuffered ${PARSER}
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

alias kube="kubectl"
alias jsonlog="sternToJQ"

alias wo="webstorm ."
alias rmo="rubymine ."

alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-on="defaults write -g ApplePressAndHoldEnabled -bool true"

alias dcup="docker-compose up"

alias iams="iam kubernetes-staging"
alias iamp="iam kubernetes-production"

# ----- EXPORTS ----- #

export EDITOR=vim
export ANDROID_HOME=/Users/julienvincent/Library/Android/sdk
export AWS_VAULT_KEYCHAIN_NAME=login
export RBENV_ROOT="/usr/local/var/rbenv"
export PATH=$PATH:$(go env GOPATH)/bin

# For node-rdkafka
export CPPFLAGS=-I/usr/local/opt/openssl/include
export LDFLAGS=-L/usr/local/opt/openssl/lib

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

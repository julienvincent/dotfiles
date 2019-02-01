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

# ----- AUTO-COMPLETION ----- #

source <(kubectl completion zsh)
source <(stern --completion=zsh)

# ----- ALIASES ----- #

alias kube="kubectl"
alias kube-ns="kubectl config set-context $(kubectl config current-context) --namespace"
alias rn="react-native"
alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool true"
alias preview="fzf --preview 'bat --color \"always\" {}'"

# JourneyApps stuff
screen_base="id:1808089285 res:2560x1440x60"
alias iamsitting="displayplacer '${screen_base} origin:(-426,-1440)'"
alias iamstanding="displayplacer '${screen_base} origin:(1680,-390)'"

# ----- EXPORTS ----- #

export EDITOR=vim
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"
export ANDROID_HOME=/Users/julienvincent/Library/Android/sdk
export AWS_VAULT_KEYCHAIN_NAME=login

# ----- AUTO ----- #

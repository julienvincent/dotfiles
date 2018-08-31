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

# ----- ALIASES ----- #

alias kube="kubectl"
alias kubed="yarn kube"
alias rn="react-native"
alias jacl="journey-dev"
alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool false"
alias keyrepeat-off="defaults write -g ApplePressAndHoldEnabled -bool true"
alias preview="fzf --preview 'bat --color \"always\" {}'"

# ----- EXPORTS ----- #

export EDITOR=vim
export FZF_DEFAULT_OPTS="--bind='ctrl-o:execute(code {})+abort'"

# ----- AUTO ----- #

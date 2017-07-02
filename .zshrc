export ZSH=/Users/julienvincent/.oh-my-zsh

ZSH_CUSTOM=$HOME/.zsh-theme
ZSH_THEME="lambda"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

ENABLE_CORRECTION="false"

# Plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git wd)

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
source $ZSH/oh-my-zsh.sh

wd() {
  . /Users/julienvincent/bin/wd/wd.sh
}

source ~/.aliases
source ~/.env

# DOCKER MACHINE
#if [ "$(docker-machine status)" = "Running" ]
#then
#    eval "$(docker-machine env default)"
#fi
#start-docker() {
#    if [ "$(docker-machine status)" = "Running" ]
#    then
#        eval "$(docker-machine env default)"
#    else
#        docker-machine start default
#        start-docker
#    fi
#}

# GOOGLE CLOUD
source '/Applications/google-cloud-sdk/path.zsh.inc'
source '/Applications/google-cloud-sdk/completion.zsh.inc'

# NVM
export NVM_DIR="/Users/julienvincent/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# OPAM
. /Users/julienvincent/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

export PATH="$PATH:`yarn global bin`"

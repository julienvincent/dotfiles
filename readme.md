# Dot Files

## Installation

### Using Git and the init script

```bash
git clone https://github.com/julienvincent/dotfiles.git ~/.dotfiles && source ~/.dotfiles/init.sh
```

To update:

```bash
source ~/.dotfiles/bootstrap.sh
```

### Sensible OS X defaults

```bash
~/.dotfiles/.osx
```

### Install Homebrew

```bash
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)" && \
sh brew.sh
```

### Do all the above

```bash
source ~/.dotfiles/init.sh
```
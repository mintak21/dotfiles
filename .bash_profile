# GOPATH
export GOPATH="$HOME/go"
export GOENV_ROOT="$HOME/.goenv"
eval "$(goenv init -)"
export PATH="$PATH:$GOPATH/bin"

# Ruby env
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# Python env
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# load bashrc
source ~/.bashrc

# load completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi

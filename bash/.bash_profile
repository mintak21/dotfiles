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

# kube-ps1
export KUBE_PS1_SYMBOL_USE_IMG=true
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_PREFIX='<'
export KUBE_PS1_SUFFIX='>'

# use hub aliased as git
eval "$(hub alias -s)"

# load bashrc
source ~/.bashrc

# load completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi


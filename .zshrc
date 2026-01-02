# Require tools via brew install before loading plugins
autoload -Uz compinit
compinit

setopt auto_cd
setopt auto_pushd
setopt no_beep
setopt hist_expand

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

HISTSIZE=100000
SAVEHIST=1000000

# Tools
eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(zabrze init --bind-keys)"
# Terminal
# Source for Git PS1 function
if [ "$PS1" != "" ]; then
    git_ppt_sh='/usr/local/etc/bash_completion.d/git-prompt.sh'
    if ! type -t __git_ps1 && [ -e "${git_ppt_sh}" ]; then
        . $git_ppt_sh
    fi
    
    PS1='[\[\033[1;36m\]\u\[\033[00m\]:\[\033[00;94m\]\w\[\033[00m\] \[\033[04;91m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\033[00m\] \[\033[32m\]\t\033[00m\]]\n\$ '

    
fi

# alias(for Mac)
alias brew="env PATH=/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin brew" # anacondaなど余計なものを読み込まない

# basicなエイリアス
alias ll='ls -l -G'
alias la='ls -al -G'
alias lar='ls -altR -G'
alias gr='grep --color=auto'
alias egr='egrep --color=auto'
alias th='touch'
alias tl='tail'


# brew系のエイリアス
alias brinst='brew install'
alias brl='brew list'
alias brs='brew search'
alias bruninst='brew uninstall'
alias brup='brew upgrade' # Homebrew自身も含めてすべてアップデート
alias brd='brew doctor'
alias ckinst='brew cask install'
alias ckuninst='brew cask uninstall'
alias brb='brew bundle'
alias brbd='brew bundle dump --force' #Brewfile作成/上書き


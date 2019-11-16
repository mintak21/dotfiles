# Terminal
# Source for Git PS1 function
if [ "$PS1" != "" ]; then
    git_ppt_sh=
    if ! type -t __git_ps1 && [ -e "${git_ppt_sh}" ]; then
        . $git_ppt_sh
    fi
    
    PS1='[\[\033[1;96m\]$\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[93;07m\]$(__git_ps1 " (%s)" 2>/dev/null) \[\033[32m\]\t]\n\$ '
    
fi

# alias
alias ll='ls -l --color=auto'
alias la='ls -a --color=auto'
alias lar = 'ls -altR --color=auto'
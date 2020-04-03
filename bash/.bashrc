# Terminal

# Colors
# Normal
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

# Bold
BBlack='\033[1;30m'       # Black
BRed='\033[1;31m'         # Red
BGreen='\033[1;32m'       # Green
BYellow='\033[1;33m'      # Yellow
BBlue='\033[1;34m'        # Blue
BPurple='\033[1;35m'      # Purple
BCyan='\033[1;36m'        # Cyan
BWhite='\033[1;37m'       # White

# Background
On_Black='\033[40m'       # Black
On_Red='\033[41m'         # Red
On_Green='\033[42m'       # Green
On_Yellow='\033[43m'      # Yellow
On_Blue='\033[44m'        # Blue
On_Purple='\033[45m'      # Purple
On_Cyan='\033[46m'        # Cyan
On_White='\033[47m'       # White

# Reset
NC="\033[m"

# Source for Git PS1 function
if [ "$PS1" != "" ]; then
	# git branch表示
	git_ppt_sh='/usr/local/etc/bash_completion.d/git-prompt.sh'
	if ! type -t __git_ps1 && [ -e "${git_ppt_sh}" ]; then
		. ${git_ppt_sh}
	fi

	# k8s cluster表示
	kube_ps1_sh='/usr/local/opt/kube-ps1/share/kube-ps1.sh'
	if [ -e "${kube_ps1_sh}" ]; then
		. ${kube_ps1_sh}
	fi
	PS1='[\[\033[1;36m\]\u\[\033[00m\]:\[\033[00;93m\]\w\[\033[00m\] \[\033[04;91m\]$(__git_ps1 "(%s)" 2>/dev/null)\[\033[00m\] $(kube_ps1) \[\033[92m\]\t\033[00m\]]\n\$ '
fi

# alias(for Mac)
alias brew="env PATH=/usr/local/bin:/usr/bin:/usr/sbin:/bin:/sbin brew" # anacondaなど余計なものを読み込まない

# basicなエイリアス
alias ll='ls -l -G'
alias la='ls -al -G'
alias lar='ls -altR -G'
alias gr='grep --color=auto'
alias egr='egrep --color=auto'

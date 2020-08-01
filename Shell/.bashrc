# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# re-set PATH for Synology NAS
export PATH=$PATH:/usr/local/git/bin

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=9000
HISTFILESIZE=5000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# enable color support of ls and also add handy aliases
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

# Set terminal type as xterm-color to show fancy propmpt and ls
export TERM="xterm-color"

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='[${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]]\$ '
else
    PS1='[${debian_chroot:+($debian_chroot)}\u@\h:\w]\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

#    alias grep='grep --color=auto'
#    alias fgrep='fgrep --color=auto'
#    alias egrep='egrep --color=auto'
fi


# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'


# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi


######################
# User configuration #
######################

# Determine whether acciio local address
ACCIIO_LOCAL_NETWORK="192.168.13"
IP_ADDRESSES=`ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'`
IS_ACCIIO_LOCAL="false"

for IP in $IP_ADDRESSES; do
    TRIMMED_IP=`echo $IP | awk -F'.' '{print $1,$2,$3}' OFS='.'`

    if [[ "$TRIMMED_IP" == $ACCIIO_LOCAL_NETWORK ]];
        then
            IS_ACCIIO_LOCAL="true"
    fi
done


# User specific aliases and functions
if [[ "$OSTYPE" == "darwin"* ]]; then
	alias cp='gcp -i'
	alias cp-p='gcp -a'
	alias mv='gmv -i'
	alias lsl='gls -lF --color=auto'
	alias lsa='gls -alF --color=auto'
	alias rm='grm'
else
	alias cp='cp -i'
	alias cp-p='cp -a'
	alias mv='mv -i'
	alias lsl='ls -lF'
	alias lsa='ls -alF'
fi

alias cls='clear'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias getall='nohup wget -t 0 -m -q'
alias myip="curl http://ipecho.net/plain; echo"

# System access (Personal)
alias andy='ssh -p 2022 andy.kaist.ac.kr'
alias liso='ssh -p 2022 liso.or.kr'
alias andymac='ssh -p 2022 andymac.kaist.ac.kr'
alias andyxen='ssh -p 2022 andyxen.kaist.ac.kr'
alias andyhomemac='ssh -p 8022 jaeeon.iptime.org'
alias andyhomenas='ssh -p 1022 jaeeon.iptime.org'
alias andyhomenas1='ssh -p 1022 jaeeon.iptime.org'
alias andyhomenas2='ssh -p 2022 jaeeon.iptime.org'
alias mklinux='ssh -l jaeeon -p 50022 143.248.56.148'

# System access (KISTI)
#alias sshDeploy="ssh -p 22002 root@150.183.251.111"
alias sshDeploy="ssh -p 22002 root@150.183.251.182"
# 2019.11.29 New
alias sshDeployNew="ssh -p 22002 root@150.183.251.171"
alias sshLiso="ssh -p 2022 hycho@liso.or.kr"
alias sshNurionClouda05="ssh clouda05@nurion.ksc.re.kr" 
alias sshTestBed="ssh -p 22002 150.183.249.86"
alias sshTestBedRoot="ssh -p 22002 root@150.183.249.86"


# Openstack Testbed
alias cdosetc="cd /etc/openstack_deploy"
alias cdosopt="cd /opt/openstack-ansible/"
alias cdnet="cd /etc/sysconfig/network-scripts"
alias cdVagrant="cd /Users/hycho/OpenStack/OS_test2-OS-Ansible/vagrant-openstack"
# System access (acciio)
if [[ "$IS_ACCIIO_LOCAL" == "true" ]]; then
    alias devmac='ssh 192.168.13.20'
    alias acciiomac='ssh 192.168.13.20'
    alias devubuntu='ssh 192.168.13.30'
    alias devfidelius='ssh 192.168.13.40'
else
    alias devmac='ssh -p 2022 acciio.iptime.org'
    alias acciiomac='ssh -p 2022 acciio.iptime.org'
    alias devubuntu='ssh -p 3022 acciio.iptime.org'
    alias devfidelius='ssh -p 4022 acciio.iptime.org'
fi

#alias devfideliusnote='ssh 192.168.1.125'
alias andypi='ssh -p 19922 pi@jaeeon.iptime.org'
alias acciiopi='ssh -p 9022 pi@acciio.iptime.org'
alias acciiopitest='ssh pi@192.168.13.150'

# System access (Cloud)
alias api='ssh -i ~/.ssh/acciio.apiserver.seoul.pem ubuntu@muffliato-api.acciio.com'
alias muffliato='ssh -i ~/.ssh/acciio.apiserver.seoul.pem ubuntu@muffliato-api.acciio.com'
alias aparecium='ssh -i ~/.ssh/acciio.apiserver.seoul.pem ubuntu@aparecium-api.acciio.com'
alias webair='ssh acciio@52.170.25.238'
alias preorder='ssh -i ~/.ssh/acciio.apiserver.seoul.pem ubuntu@preorder.acciio.com'
alias pokeapi='ssh -i ~/.ssh/acciio.apiserver.nvirginia.pem ubuntu@pokechat-api.acciio.com'
alias pokechat='ssh -i ~/.ssh/acciio.apiserver.nvirginia.pem ubuntu@pokechat-api.acciio.com'
#alias web='ssh acciio@acciio.com'
alias web='ssh acciio@104.208.247.108'
alias db='mysql -h acciiomysql.cydg3eid6nev.ap-northeast-2.rds.amazonaws.com -u acciio -p'
alias dbadmin='mysql -h acciiomysql.cydg3eid6nev.ap-northeast-2.rds.amazonaws.com -u admin -p'

# scp
alias scpandy='scp -P 2022'
alias sscp='scp -P 2022'
alias scpaws='scp -i ~/.ssh/acciio.apiserver.seoul.pem'
alias awsscp='scp -i ~/.ssh/acciio.apiserver.seoul.pem'


# ARTIK development
BOARDNAME=artik530
ARTIK_BASE_DIR=~/Develop/acciio/Fidelius/ARTIK

alias acd="cd $ARTIK_BASE_DIR"
alias acd-build="cd $ARTIK_BASE_DIR/build-artik"
alias acd-kernel="cd $ARTIK_BASE_DIR/linux-artik7"
alias acd-uboot="cd $ARTIK_BASE_DIR/u-boot-artik7"
alias acd-image="cd $ARTIK_BASE_DIR/build-artik/output/images/artik530"

alias akernel-config="make ARCH=arm artik530_raptor_defconfig; make ARCH=arm menuconfig"
alias akernel-save="make ARCH=arm savedefconfig; mv defconfig arch/arm/configs/artik530_raptor_defconfig"

alias ab-release="./release.sh -c config/artik530.cfg --local-rootfs ../ubuntu-rootfs-andy/rootfs.tar.gz"
alias ab-uboot="./build_uboot.sh -b $BOARDNAME"
alias ab-kernel="./build_kernel.sh -b artik530; ./mkbootimg.sh -b $BOARDNAME"
alias ab-kernel-andy="./andy_build_kernel.sh -b artik530; ./mkbootimg.sh -b $BOARDNAME"

alias af-uboot="sudo fastboot flash bootloader bootloader.img"
alias af-kernel="sudo fastboot flash boot boot.img"
alias af-modules="sudo fastboot flash modules modules.img"
alias af-reboot="sudo fastboot reboot"

alias mount-artik="sshfs -o idmap=user jaeeon@192.168.13.40:/home/jaeeon/Develop/acciio/Fidelius /Users/jaeeon/Develop/acciio/Fidelius_Ubuntu/"
#alias mount-artik-note="sshfs -o idmap=user jaeeon@192.168.1.125:/home/jaeeon/Develop/acciio/Fidelius /Users/jaeeon/Develop/acciio/Fidelius_Ubuntu/"
alias mount-air="sshfs -o idmap=user root@192.168.13.195:/root /Users/jaeeon/Develop/acciio/AIR/air_board/ -o defer_permissions -o volname=acciioAirDevice"


# Kakao Hadoop client
alias kinit-krane="kinit andy.a"
alias kinit-hadoop="kinit -kt ~/Develop/andy-dev-env/kakao/hadoop/andy-a.keytab andy-a@KAKAO.HADOOP"


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

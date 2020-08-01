# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# re-set PATH for Synology NAS
export PATH=$PATH:/usr/local/git/bin

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
#ZSH_THEME="agnoster-andy"
#ZSH_THEME="amuse"
#ZSH_THEME="refined"
ZSH_THEME="bira"

# Uncomment the following line to use case-sensitive completion.
CASE_SENSITIVE="true"

# added by hyeyoung (2020.02.22)
ZSH_DISABLE_COMPFIX=true

# added by hyeyoung test (2020.02.22)

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	common-aliases
	zsh-syntax-highlighting
	zsh-autosuggestions
	forgit
)

source $ZSH/oh-my-zsh.sh


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


# System common environment variable
export PATH=$HOME/bin:$PATH:/sbin:/usr/sbin:/bin:/usr/bin:/usr/local/bin:/usr/local/sbin
export LD_LIBRARY_PATH=/usr/local/lib${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}


# System specific environment variable
if [[ "$OSTYPE" == "darwin"* ]]; then
    # System PATH
    export PATH=$PATH:~/Library/Android/sdk/platform-tools

    # Android SDK
    export ANDROID_HOME=~/Library/Android/sdk

    # CUDA
    #export CUDA_HOME=/Developer/NVIDIA/CUDA
    export CUDA_HOME=/usr/local/cuda
    export PATH=$PATH:$CUDA_HOME/bin
    export DYLD_LIBRARY_PATH=$CUDA_HOME/lib${DYLD_LIBRARY_PATH:+:${DYLD_LIBRARY_PATH}}
    export LD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:$LD_LIBRARY_PATH

    # Espressif ESP32
    export IDF_PATH=~/Develop/esp/esp-idf
	alias espenv='source $IDF_PATH/export.sh'

#    if [ -f $IDF_PATH/export.sh ];
#        then source $IDF_PATH/export.sh > /dev/null;
#    fi

	# Syntax highlighting
	source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

	# Java 8
	export JAVA_HOME=$(/usr/libexec/java_home -v1.8)

else
    export PATH=$PATH:/usr/X11R6/bin

	# Java 8
	export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
fi


# jenv to manage multiple versions of Java
export PATH=$PATH:$HOME/.jenv/bin
if which jenv > /dev/null; then
    eval "$(jenv init -)"
fi

# Hide username
#prompt_context() {} 

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Common alias
if [[ "$OSTYPE" == "darwin"* ]]; then
    alias cp='gcp -i'
    alias cp-p='gcp -a'
    alias mv='gmv -i'
	alias ls='gls --color=auto'
    alias rm='grm'
else
    alias cp='cp -i'
    alias cp-p='cp -a'
    alias mv='mv -i'
fi

alias lsl='ls -lh'
alias cls='clear'
alias getall='nohup wget -t 0 -m -q'
alias myip="curl http://ipecho.net/plain; echo"

# System access (Personal)
alias liso='ssh -p 2022 hycho@liso.or.kr'

# System access (KISTI)
#alias sshDeploy="ssh -p 22002 root@150.183.251.111"
alias sshDeploy="ssh -p 22002 root@150.183.251.182"
# 2019.11.29 New
alias sshDeployNew="ssh -p 22002 root@150.183.251.171"
alias sshLiso="ssh -p 2022 hycho@liso.or.kr"
alias sshNurionClouda05="ssh clouda05@nurion.ksc.re.kr"
alias sshTestBed="ssh -p 22002 150.183.249.86"
alias sshTestBedRoot="ssh -p 22002 root@150.183.249.86"
# 2020.06.25 New Because 249.86 Hacking
alias sshTestBedRoot2="ssh -p 22002 root@150.183.249.88"


# Openstack Testbed
alias cdosetc="cd /etc/openstack_deploy"
alias cdosopt="cd /opt/openstack-ansible/"
alias cdnet="cd /etc/sysconfig/network-scripts"
alias cdVagrant="cd /Users/hycho/OpenStack/OS_test2-OS-Ansible/vagrant-openstack"
alias findex="find . -name *.* | xargs grep -r --color=auto -n bond"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

#test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

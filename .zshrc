
# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="omega"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

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
# HIST_STAMPS="dd/mm/yyyy"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.



## plugins=(git gitfast git-extras jsontools mvn pyenv pylint python screen sudo systemd vagrant web-search autopep8 common-aliases compleat django encode64 zsh-completions )
# Warning you don't need git, cause gitfast is it's faster cousin, git extras is for commands you never use,
# mvn unless you start doing java again, pyenv is hella slow, systemd is only relevant to linux, autopep8 is slow, you haven't touched django in ages

plugins=(gitfast
jsontools
pylint
python 
sudo
common-aliases
compleat 
encode64 
zsh-completions 
kubectl 
docker 
autopep8 
aws 
extract 
pip 
)

echo 1
source $ZSH/oh-my-zsh.sh
# This is slow and is already called in oh-my-zsh.sh
# autoload -U compinit && compinit

# User configuration
#source .exportsrc

# OS Specific config
# if [ $OPERATING_SYSTEM = 'OSX' ]; then
#   source .osx.sh
#this part causes invalid end of file #else if [ $OPERATING_SYSTEM = 'Linux' ]; then
# #   source .linux.sh
# fi


## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
echo 2
# command completion: highlight matching part of command
zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'
echo 3
# activate menu selection
zstyle ':completion:*' menu select

# activate approximate completion, but only after regular completion (_complete)
zstyle ':completion:::::' completer _complete _approximate
# limit to 2 errors
zstyle ':completion:*:approximate:*' max-errors 2
echo 4
# check zshoptions to see what these do
setopt notify nohashdirs autocd globdots hist_ignore_all_dups noclobber auto_menu pathdirs cdablevars checkjobs dotglob  histverify histappend inc_append_history  autolist listtypes prompt_subst rmstarsilent complete_in_word nohup
export MANPATH="/usr/local/man:$MANPATH"

# no beep sound
setopt nolistbeep no_beep

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# get notified when someone logs in
watch=all                       # watch all logins
logcheck=30                     # every 30 seconds
WATCHFMT="%n from %M has %a tty%l at %T %W"


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

alias dev="cd $HOME/code"
alias serve="python3 -m http.server"
alias k="kubectl"


# copy with a progress bar.
alias cpv="rsync -poghb --backup-dir=/tmp/rsync -e /dev/null --progress --"

# p() {
#  cd "$PROJECTS/$(find "$PROJECTS" -maxdepth 5 -name .git | sed 's#/\.git$##' | sed "s#^$PROJECTS/##" | selecta)"
#}

# source dotfiles
reload() {
    source $HOME/.zshrc &&
        echo "Your dot files are now \033[1;32msourced\033[0m."
}


# auto start tmux 
#
if [[ -z "$TMUX" ]] ; then
    tmux attach-session -t ssh_tmux || tmux new-session -s ssh_tmux
fi


if [ $commands[helm] ]; then
        source <(helm completion $(basename ${SHELL}))
fi

if [ $commands[kubectl] ]; then
        source <(kubectl completion $(basename ${SHELL}))
fi

if [ $commands[minikube] ]; then
        source <(minikube completion $(basename $SHELL))
fi

 # for https://please.build/
if [ $commands[plz] ]; then
        source <(plz --completion_script)
fi


function git-update-all-branches(){
        urrent_branch=$(git branch | grep \* | cut -d ' ' -f2)

        git fetch origin master

        for br in $(git branch --format='%(refname:short)')
        do
            (git checkout $br && git rebase origin/master)
        done

        git checkout $current_branch
}


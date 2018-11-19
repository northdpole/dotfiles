
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
plugins=(gitfast jsontools pylint python screen sudo web-search common-aliases compleat encode64 zsh-completions)

source $ZSH/oh-my-zsh.sh
# This is slow and is already called in oh-my-zsh.sh
# autoload -U compinit && compinit

# User configuration
source .exportsrc

# OS Specific config
 if [ $OPERATING_SYSTEM = 'OSX' ]; then
   source .osx.sh
#this part causes invalid end of file #else if [ $OPERATING_SYSTEM = 'Linux' ]; then
# #   source .linux.sh
 fi


## add colors to processes for kill completion
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'

# command completion: highlight matching part of command
zstyle -e ':completion:*:-command-:*:commands' list-colors 'reply=( '\''=(#b)('\''$words[CURRENT]'\''|)*-- #(*)=0=38;5;45=38;5;136'\'' '\''=(#b)('\''$words[CURRENT]'\''|)*=0=38;5;45'\'' )'

# activate menu selection
zstyle ':completion:*' menu select

# activate approximate completion, but only after regular completion (_complete)
zstyle ':completion:::::' completer _complete _approximate
# limit to 2 errors
zstyle ':completion:*:approximate:*' max-errors 2

# check zshoptions to see what these do
setopt notify nohashdirs autocd globdots hist_ignore_all_dups noclobber auto_menu pathdirs cdablevars checkjobs dotglob  histverify histappend autolist listtypes prompt_subst rmstarsilent complete_in_word nohup
export MANPATH="/usr/local/man:$MANPATH"

# no beep sound
setopt nolistbeep no_beep

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# get notified when someone logs in
#watch=all                       # watch all logins
#logcheck=30                     # every 30 seconds
#WATCHFMT="%n from %M has %a tty%l at %T %W"


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


# alias mkvenv="virtualenv venv -p python3 && source venv/bin/activate && pip install -r requirements.txt"

#MAIL=/var/spool/mail/($whoami) && export MAIL


# pv wrapper that imitates cp usage

function cpv()
{
  local DST=${@: -1}                    # last element
  local SRC=( ${@: 1 : $# - 1} )        # array with rest of elements

  # checks
  type pv &>/dev/null || { echo "install pv first"; return 1; }
  [ $# -lt 2  ]       && { echo "too few args"    ; return 1; }




  # special invocation
  function cpv_rename()
  {
    local SRC="$1"
    local DST="$2"
    local DSTDIR="$( dirname "$DST" )"

    # checks
    if   [ $# -ne 2     ]; then echo "too few args"          ; return 1; fi
    if ! [ -e "$SRC"    ]; then echo "$SRC doesn't exist"    ; return 1; fi
    if   [ -d "$SRC"    ]; then echo "$SRC is a dir"         ; return 1; fi
    if ! [ -d "$DSTDIR" ]; then echo "$DSTDIR does not exist"; return 1; fi

    # actual copy
    echo -e "\n$SRC 🡺  $DST"
    pv   "$SRC" >"$DST"
  }

  # special case for cpv_rename()
  if ! [ -d "$DST" ]; then cpv_rename "$@"; return $?; fi;

  # more checks
  for src in "${SRC[@]}"; do
    local dst="$DST/$( basename "$src" )"
    if ! [ -e "$src" ]; then echo "$src doesn't exist" ; return 1;
    elif [ -e "$dst" ]; then echo "$dst already exists"; return 1; fi
  done

  # actual copy
  for src in "${SRC[@]}"; do
    if ! [ -d "$src" ]; then
      local dst="$DST/$( basename "$src" )"
      echo -e "\n$src 🡺  $dst"
      pv "$src" > "$dst"
    else
      local dir="$DST/$( basename "$src" )"
      mkdir "$dir" || continue
      local srcs=( $src/* )
      cpv "${srcs[@]}" "$dir";
    fi
  done
  unset cpv_rename
}

if [ -x $(which cowsay) -a -x $(which fortune) ]; then
        fortune -s | cowsay -f daemon;
fi

source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

source /usr/local/opt/git-extras/share/git-extras/git-extras-completion.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/vault vault

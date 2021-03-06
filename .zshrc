#Know the linux distro
distro=$(lsb_release -si)
if [ "$distro" = "Solus" ]; then
    PaqueteTMux=$(eopkg bl tmux)
    PaqueteVIM=$(eopkg bl vim)
    PaqueteNVIM=$(eopkg bl neovim)
    alias instala="sudo eopkg it -y"
    alias informa="sudo eopkg bl"
elif [ "$distro" = "Ubuntu" ]; then
    PaqueteTMux=$(dpkg --get-selections | grep -w tmux | grep -w install)
    PaqueteVIM=$(dpkg --get-selections | grep -w vim | grep -w install)
    PaqueteNVIM=$(dpkg --get-selections | grep -w nvim | grep -w install)
    alias instala="sudo apt-fast install -y"
    alias informa="sudo apt install"
fi
if [ "$distro" != "" ]; then
    # Init TMux
    if [ "$PaqueteTMux" != "" ]; then
        tmux
    fi

    # Preferred editor for local and remote sessions
    # Change MVIM for VIM
    if [ "$PaqueteVIM" != "" ]; then
        export EDITOR="vim"
    elif [ "$PaqueteNVIM" != "" ]; then
        export EDITOR="nvim"
        alias vim="nvim"
        alias vi="nvim"
    else
        export EDITOR="nano"
    fi
fi
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
# ZSH_THEME="bureau"

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
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(bundler git rails npm pip python sudo sublime web-search git-extras vagrant wd colorize colored-man-pages command-not-found cp rsync taskwarrior redis-cli systemd)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
export LANG=es_ES.UTF-8

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

 source $HOME/antigen.zsh

# Load the oh-my-zsh's library
antigen use oh-my-zsh

antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-completions
antigen bundle lukechilds/zsh-nvm
antigen bundle hlissner/zsh-autopair

# Load the theme
antigen theme https://github.com/caiogondim/bullet-train-oh-my-zsh-theme bullet-train

# Tell antigen that you're done
antigen apply

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

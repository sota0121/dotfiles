# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gnzh"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "avit" "gnzh" "intheloop" "strug" "tjkirch" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  zsh-autosuggestions
  zsh-syntax-highlighting
  zsh-history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

#### oh-my-zsh configuration is end ####

# ====================
# Global My Config
# ====================
# To avoid error happening when nvim tries to open lots of files
ulimit -n 4096

# ============================================
# PATH
# ============================================
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/sbin
export PATH=$PATH:/Applications

# Go Modules as tools
export PATH="$PATH:/usr/local/go/bin"
export PATH=$PATH:"$(go env GOPATH)"
export PATH=$PATH:"$(go env GOPATH)/bin"

# For using gawk as awk
# gawk is used by asdf
export PATH=$PATH:/opt/homebrew/opt/gawk/libexec/gnubin

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# asdf - specify the current asdf node version dynamically
export PATH="$(dirname $(asdf which node)):$PATH"

# ===========================================
# Aliases
# ===========================================
alias tf="terraform"

# fzf aliases
# -- fuzzy find history
# Interactive history search, copy to clipboard and show message
fzfh_func() {
  local cmd
  cmd=$(history | fzf --with-nth=2.. --bind "enter:accept")
  if [[ -n "$cmd" ]]; then
    # Remove the leading number and whitespace from the command
    cmd=$(echo "$cmd" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//')
    # Copy the command to clipboard (macOS)
    # For Linux, you can use xclip or xsel instead of pbcopy
    echo "$cmd" | pbcopy
    echo "✅ Copied to clipboard: $cmd"
  fi
}
alias fzfh="fzfh_func"
# -- fuzzy find with previewing
alias fzfpv="fzf --preview 'cat {}'"

# lazygit with custom config file
alias lazygitc="lazygit -ucf ~/.lazygit/config.yml"

# ============================================
# Homebrew settings
# ============================================
export PATH=$PATH:/opt/homebrew/bin

# ===========================================
# Golang settings
# ===========================================
# https://go.dev/wiki/SettingGOPATH
export GOPATH=$HOME/go

# ============================================
# pyenv / pyenv-virtualenv settings (installed via homebrew)
# ===========================================
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# ===========================================
# Deno settings
# ===========================================
export DENO_INSTALL="/Users/masuda.sota/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"




# ==========================================
# Google Cloud SDK Settings
# ==========================================
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sota/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sota/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sota/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sota/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# ==========================================
# Minikube settings
# ==========================================
alias kubectl="minikube kubectl --"


# ==========================================
# node settings (installed via homebrew)
# ==========================================
# nodenv
# eval "$(nodenv init -)" -- no longer use nodenv. start to use asdf.

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /opt/homebrew/bin/terraform terraform

# bun completions
[ -s "/Users/sota/.bun/_bun" ] && source "/Users/sota/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ==========================================
# asdf settings
# https://asdf-vm.com/guide/getting-started.html
# ==========================================
# Path
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Prework is done by myself
# mkdir -p "${ASDF_DATA_DIR:-$HOME/.asdf}/completions"
# asdf completion zsh > "${ASDF_DATA_DIR:-$HOME/.asdf}/completions/_asdf"

# append completions to fpath
fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

# ==========================================
# tmux conf loading
# ==========================================
# Function to start tmux and source the config file
start_tmux() {
  if command -v tmux &> /dev/null; then
    if ! tmux has-session -t default 2>/dev/null; then
      tmux new-session -d -s default
      tmux source-file ~/.tmux.conf
    fi
  fi
}

# Automatically start tmux and source the configuration file on terminal startup
start_tmux



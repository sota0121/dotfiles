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
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

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
	zsh-history-substring-search
	zsh-syntax-highlighting
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
export PATH=$PATH:"$(go env GOPATH)"
export PATH=$PATH:"$(go env GOPATH)/bin"

# For using gawk as awk
# gawk is used by asdf
export PATH=$PATH:/opt/homebrew/opt/gawk/libexec/gnubin

# krew
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

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
# pyenv / pyenv-virtualenv settings
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

# ===========================================
# jira CLI settings
# ===========================================
# I created custom directory for jira-cli named `.atlassian-jira`
# and put secrets.env file in it.
if [ -f "$HOME/.atlassian-jira/secrets.env" ]; then
    set -a
    source "$HOME/.atlassian-jira/secrets.env"
    set +a
fi

# ===========================================
# Azure DevOps settings
# ===========================================
# I created custom directory for Azure DevOps named `.azure-devops`
# and put secrets.env file in it.
if [ -f "$HOME/.azure-devops/secrets.env" ]; then
    set -a
    source "$HOME/.azure-devops/secrets.env"
    set +a
fi

# ==========================================
# asdf (multiple ver. runtime management) settings
# ==========================================
. /opt/homebrew/opt/asdf/libexec/asdf.sh


# pnpm - added automatically by `pnpm setup` command
export PNPM_HOME="/Users/masuda.sota/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/masuda.sota/.bun/_bun" ] && source "/Users/masuda.sota/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ==========================================
# argo cli envvars
# this is from https://argo.test.musubu.co.in/userinfo
# ==========================================
export ARGO_SERVER='argo.test.musubu.co.in:443' 
export ARGO_HTTP1=true  
export ARGO_SECURE=true
export ARGO_BASE_HREF=
export ARGO_TOKEN='Bearer v2:eyJhbGciOiJSU0EtT0FFUC0yNTYiLCJlbmMiOiJBMjU2R0NNIiwiemlwIjoiREVGIn0.y5VwAC_ZulWc1HS1XEnGdPIVdURZNZ02z4tSmwdCFeEiRlDVcMPc83-z-Vtg0Gv6T9bu5vs7sq7R6zWXnjBtBj8EWNX_Not34VwxTMUezoh-Z85oipsPUCft1R37DiHBCreZOpSwcSk5-L76ukAxta2zfOff-61JXPkxqfiLGwGUlaOONy-g2kh_Ceft2iIRNM5A6GcovItyOquuTaQqpmlHI2Vyps1l4q6jGvOpiabEHhLhRoAFOaNCv4ilMeFil3M1xRhC618tGdkad2935iol-BmltIK_YflSUHVN7N0v7d_XCjjqlziQfb_ngz8TBHBIN7EUarxPPkSk6RYnjw.CX2ZE6SnUzrFBm3r.I5YxLFI6lPgriSbR_VhfeevHaOxSHOhaZZk6r_MuU3WoL2VvfZuFAwyLjbJxWkUn5rmSYkImv01C6XOtjRvSb5qYyCjkKTZ2JZptfCEzKdpFkgYN3LLsqoIMkFBDprBKCM6ALBGHdCHgDxdB1w2c8YNjJ0Ayshti3aBD3S2y_jnPj2qNG8ErbjKvZCYqX2cIb6WQ91xK0jcGGg7pFyQ5h1ax3Vc-4RNuNSa6qE2EdhOuUJ1XtnEKepFI7RNVB2okDi2gAPM.CcuCauSYzF3aF3eGsTY9tw' 
export ARGO_NAMESPACE=argo ;# or whatever your namespace is 
export KUBECONFIG=/dev/null ;# recommended
export PATH="$PATH:/Users/masuda.sota/.modular/bin"


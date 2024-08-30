export ZDOTDIR="$HOME/.config/zsh"

# -----------------------------------------------------------------------------
# ********************************* Plugins ***********************************
# -----------------------------------------------------------------------------

autoload -Uz compinit; compinit

source $ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh
source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source $ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source "$ZDOTDIR/plugins/gitstaus/gitstatus.prompt.zsh"

# -----------------------------------------------------------------------------
# ********************************* Aliases ***********************************
# -----------------------------------------------------------------------------

source $ZDOTDIR/zsh-aliases


# -----------------------------------------------------------------------------
# ********************************* History ***********************************
# -----------------------------------------------------------------------------

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

# Sift through history matching up to current cursor position
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

# Moves the cursor to the end of line after each match
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search


# -----------------------------------------------------------------------------
# ****************************** Key bindings *********************************
# -----------------------------------------------------------------------------

bindkey "^[[1;3A" beginning-of-line # Option + ARROW_UP
bindkey "^[[1;3B" end-of-line # Option + ARROW_DOWN
bindkey "^[[1;3C" forward-word # Option + ARROW_RIGHT - cursor forward 1 word
bindkey "^[[1;3D" backward-word # Option + ARROW_LEFT - cursor backward 1 word

bindkey "^Z" undo # CTRL+Z
bindkey "^Y" redo # CTRL+Y

bindkey "^[[A" up-line-or-beginning-search # ARROW_UP
bindkey "^[[B" down-line-or-beginning-search # ARROW_DOWN


# -----------------------------------------------------------------------------
# *********************************** Prompt **********************************
# -----------------------------------------------------------------------------

setopt PROMPT_SUBST

PROMPT="%F{yellow}%~%f $ "
RPROMPT='$GITSTATUS_PROMPT %(0?||💀)'


# -----------------------------------------------------------------------------
# ********************************** Homebrew *********************************
# -----------------------------------------------------------------------------

# For adding brew and packages added via brew to $PATH
eval "$(/opt/homebrew/bin/brew shellenv)"


# -----------------------------------------------------------------------------
# ********************************** Fastfetch ********************************
# -----------------------------------------------------------------------------

if [[ "$TERM" == "xterm-kitty" ]]; then

  images=(
    ~/System/TermImages/JoaoAntunes-1.jpg 
    ~/System/TermImages/JoaoAntunes-2.jpg 
    ~/System/TermImages/JoaoAntunes-3.jpg 
    ~/System/TermImages/JoaoAntunes-4.jpg 
  )
  random_index=$((RANDOM % ${#images[@]}))

  fastfetch --logo ${images[$random_index+1]} --logo-height 28 --logo-type kitty

fi


# -----------------------------------------------------------------------------
# ************************************ Misc ***********************************
# -----------------------------------------------------------------------------

# Default editor 
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# change directories by simply typing the directory name without "cd" 
setopt autocd

# fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:ls:*' fzf-preview 'bat --color=always $realpath'

# fzf
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh


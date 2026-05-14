# -----------------------------------------------------------------------------
# ********************************* Global ************************************
# -----------------------------------------------------------------------------

# Homebrew Initialize - adds brew and brew-installed packages to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

export XDG_CONFIG_HOME="$HOME/.config"
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

export TERMINAL_ART="$HOME/Pictures/TerminalArt/pngs"

# Default editor 
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


# -----------------------------------------------------------------------------
# *********************** Machine-Specific Overlay ****************************
# -----------------------------------------------------------------------------

if [[ -f "$ZDOTDIR/host.zsh" ]]; then
  source "$ZDOTDIR/host.zsh"
fi


# -----------------------------------------------------------------------------
# ********************************* Plugins ***********************************
# -----------------------------------------------------------------------------

autoload -Uz compinit; compinit

source "$ZDOTDIR/plugins/fzf-tab/fzf-tab.plugin.zsh"
source "$ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZDOTDIR/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "$ZDOTDIR/plugins/gitstatus/gitstatus.prompt.zsh"


# -----------------------------------------------------------------------------
# ********************************** Shell ************************************
# -----------------------------------------------------------------------------

setopt autocd # cahnge directories by simply tying the name


# -----------------------------------------------------------------------------
# ********************************* History ***********************************
# -----------------------------------------------------------------------------

setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
setopt INC_APPEND_HISTORY

export HISTFILE="$ZDOTDIR/.zhistory"
export HISTSIZE=10000
export SAVEHIST=10000

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
# ********************************* Aliases ***********************************
# -----------------------------------------------------------------------------

source $ZDOTDIR/zsh-aliases


# -----------------------------------------------------------------------------
# *************************** Prompt & Fastfetch ******************************
# -----------------------------------------------------------------------------

setopt PROMPT_SUBST

PROMPT="%F{yellow}%~%f $ "
RPROMPT='$GITSTATUS_PROMPT %(0?||💀)'

# Fastfetch with random image
if [[ "$TERM" == "xterm-kitty" ]] && (( $+commands[fastfetch] )); then

  images=(
    "$TERMINAL_ART/JoaoAntunes-1.png 27 80"
    "$TERMINAL_ART/JoaoAntunes-2.png 27 50" 
    "$TERMINAL_ART/JoaoAntunes-3.png 27 50" 
  )
  random_index=$((RANDOM % ${#images[@]} + 1))
  img=(${(z)images[$random_index]})

  fastfetch --logo ${img[1]} --logo-type kitty-direct --logo-height ${img[2]} --logo-width ${img[3]}
fi


# -----------------------------------------------------------------------------
# ************************************ Misc ***********************************
# -----------------------------------------------------------------------------

# fzf
source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
source /opt/homebrew/opt/fzf/shell/completion.zsh

# fzf-tab
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'

if (( $+commands[bat] )); then
  zstyle ':fzf-tab:complete:ls:*' fzf-preview 'bat --color=always $realpath'
else
  # Shows the first 20 lines of the file as a safe fallback
  zstyle ':fzf-tab:complete:ls:*' fzf-preview 'head -n 20 $realpath'
fi


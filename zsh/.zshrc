# fastfetch
if [[ "$TERM" == "xterm-kitty" ]]; then

  images=(
    System/NeofetchImages/JoaoAntunes-1.jpg 
    System/NeofetchImages/JoaoAntunes-2.jpg 
    System/NeofetchImages/JoaoAntunes-3.jpg 
    System/NeofetchImages/JoaoAntunes-4.jpg 
  )
  random_index=$((RANDOM % ${#images[@]}))

  fastfetch --logo ${images[$random_index+1]} --logo-height 28 --logo-type kitty

elif [[ "$TERM" == "xterm-256color" && "$TERM_PROGRAM" != "vscode" ]]; then
  fastfetch --logo System/ASCII/F.txt
	
fi

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(
  git 
  zsh-autosuggestions 
  zsh-syntax-highlighting 
  you-should-use
)

source $ZSH/oh-my-zsh.sh

if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Personal aliases, run `alias` for a full list of active aliases
alias zshconfig="nvim ~/.zshrc"
alias c="clear"
alias e="exit"
alias l="ls -al"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# JAVA PATH
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"

# Lunar Vim
export PATH="$HOME/.local/bin:$PATH"

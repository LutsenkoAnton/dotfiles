# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Highlighting, autosuggestions and completions
zinit wait lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Usual plugins 
zinit wait lucid light-mode for \
    Aloxaf/fzf-tab \
    ael-code/zsh-colored-man-pages

# Stealing from oh my zsh

zinit wait lucid light-mode for \
    OMZP::sudo

# Aliases
if [[ -x $(command -v neovide) ]]; then
    alias vim="neovide --fork"
fi
if [[ -x $(command -v vim) ]]; then
    alias vi=vim
fi
if [[ -x $(command -v rg) ]]; then
    alias grep=rg
fi
if [[ -x $(command -v procs) ]]; then
    alias ps=procs
fi
if [[ -x $(command -v delta) ]]; then
    alias diff=delta
fi
if [[ -x $(command -v eza) ]]; then
    alias ls="eza --hyperlink --icons"
elif [[ -x $(command -v exa) ]]; then
    alias ls=exa
fi
alias ll="ls -lh"
alias la="ls -lah"
alias lz="ll --total-size --sort size"
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias dud="du -h -d 1"
alias killer="ps | fzf -m | awk '{print \$1}' | xargs kill"
alias assassin="ps | fzf -m | awk '{print \$1}' | xargs kill -9"

# Global aliases
alias -g H="| head"
alias -g L="| less"
alias -g T="| tail"
alias -g G="| grep"

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

if [[ -x $(command -v starship) ]]; then
    eval "$(starship init zsh)"
else
    echo "Please install starship"
fi

if [[ -x $(command -v zoxide) ]]; then
    eval "$(zoxide init zsh)"
fi

if [[ -x $(command -v fzf) ]]; then
    eval "$(fzf --zsh)"
fi

if [[ -x $(command -v thefuck) ]]; then
    eval "$(thefuck --alias)"
fi

# Plugins settings
export EXA_COLORS="da=1;36"
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS \
  --highlight-line \
  --info=inline-right \
  --ansi \
  --layout=reverse \
  --border=none
  --color=border:#27a1b9 \
  --color=fg:#c0caf5 \
  --color=gutter:#16161e \
  --color=header:#ff9e64 \
  --color=hl+:#2ac3de \
  --color=hl:#2ac3de \
  --color=info:#545c7e \
  --color=marker:#ff007c \
  --color=pointer:#ff007c \
  --color=prompt:#2ac3de \
  --color=query:#c0caf5:regular \
  --color=scrollbar:#27a1b9 \
  --color=separator:#ff9e64 \
  --color=spinner:#ff007c \
"


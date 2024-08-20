# Initialize zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Highlighting, autosuggestions and completions
zinit wait=1 lucid light-mode for \
    atinit"zicompinit; zicdreplay" \
        zdharma-continuum/fast-syntax-highlighting \
    atload"_zsh_autosuggest_start" \
        zsh-users/zsh-autosuggestions \
    blockf atpull'zinit creinstall -q .' \
        zsh-users/zsh-completions

# Zsh vi mode
zinit wait lucid light-mode depth=1 for \
    jeffreytse/zsh-vi-mode

# Usual plugins 
zinit wait=1 lucid light-mode for \
    Aloxaf/fzf-tab \
    ael-code/zsh-colored-man-pages

# Stealing from oh my zsh

zinit wait=1 lucid light-mode for \
    OMZP::sudo

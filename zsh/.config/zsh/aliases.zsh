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

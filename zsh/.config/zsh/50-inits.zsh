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

if [[ -x $(command -v opam) ]]; then
    eval "$(opam env)"
fi

# if [[ -x $(command -v stack) ]]; then
#     eval "$(stack --zsh-completion-script stack)"
#     eval "$(stack --zsh-completion-script ghc)"
# fi

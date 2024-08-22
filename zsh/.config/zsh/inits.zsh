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

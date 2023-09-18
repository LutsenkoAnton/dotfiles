# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
source $HOME/.exports

source $ZSH/oh-my-zsh.sh

source $HOME/.aliases
source $HOME/.functions

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

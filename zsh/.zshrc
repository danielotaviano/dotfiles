# Oh My Zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Editor / terminal
export TERM="xterm-256color"
alias vim=nvim
export MANPAGER="nvim +Man!"

# Secrets
[[ -f ~/.secrets/env ]] && source ~/.secrets/env

# Machine-specific config (not tracked)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# direnv
eval "$(direnv hook zsh 2>/dev/null)"
export DIRENV_LOG_FORMAT=""

# Oh My Zsh
if [ "$TMUX" = "" ]; then tmux; fi
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
source $ZSH/oh-my-zsh.sh

# Keep common iTerm2/macOS navigation shortcuts working in ZLE.
bindkey '\eb' backward-word
bindkey '\ef' forward-word
bindkey '^[[1;3D' backward-word
bindkey '^[[1;3C' forward-word
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[1~' beginning-of-line
bindkey '^[[4~' end-of-line
bindkey '^[OH' beginning-of-line
bindkey '^[OF' end-of-line

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
export PATH="$HOME/.local/bin:$PATH"

# Added by LM Studio CLI tool (lms)
export PATH="$PATH:/Users/danielotaviano/.lmstudio/bin"

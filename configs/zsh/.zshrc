export EDITOR="nvim"
export TERMINAL="kitty"
export PATH="$HOME/.local/bin:$PATH"

HISTSIZE=5000
SAVEHIST=5000
HISTFILE="$HOME/.zsh_history"
setopt HIST_IGNORE_DUPS SHARE_HISTORY AUTO_CD

autoload -Uz compinit
compinit

autoload -Uz vcs_info
precmd() {
  vcs_info
}
zstyle ':vcs_info:git:*' formats '%F{green}[%b]%f'
RPROMPT='${vcs_info_msg_0_}'

alias ll="ls -lah --color=auto"
alias gs="git status"
alias ga="git add"
alias gc="git commit"
alias gp="git push"
alias update="sudo pacman -Syu"
alias v="nvim"
alias t="tmux"

if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

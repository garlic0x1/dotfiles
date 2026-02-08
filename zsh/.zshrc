# Emacs Mode
bindkey -e

# Save History
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Tab Completion
zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
setopt globdots

# Fancy Prompt
NEWLINE=$'\n'
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
if [[ -n "$SSH_CONNECTION" ]] || [[ -n "$SSH_CLIENT" ]] || [[ -n "$SSH_TTY" ]]; then
  PROMPT='${NEWLINE}%F{yellow}%m%f %F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f${NEWLINE}λ '
else
  PROMPT='${NEWLINE}%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f${NEWLINE}λ '
fi

# Custom Variables
export PATH=~/.local/bin/:$PATH
export EDITOR=nvim
export VISUAL=nvim

# Dedupe $PATH
typeset -U PATH

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

zstyle :compinstall filename '$HOME/.zshrc'
autoload -Uz compinit
compinit
setopt globdots

bindkey -e

# set -o vi
# bindkey '^[p' up-line-or-search
# bindkey '^[n' down-line-or-search

# Git Completion
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  autoload -Uz compinit
  compinit
fi

# Fancy Prompt
NEWLINE=$'\n'
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats '%b '
setopt PROMPT_SUBST
PROMPT='${NEWLINE}%F{green}%*%f %F{blue}%~%f %F{red}${vcs_info_msg_0_}%f${NEWLINE}λ '

export PATH=~/.local/bin/:$PATH

# Dedupe $PATH
typeset -U PATH

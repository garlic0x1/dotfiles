#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias edit='hx'
alias compose="sudo docker-compose"
alias zip="tar -zcvf" # archive, dir
alias unzip="tar -zxvf" # archive
alias keygen="cat /dev/urandom | tr -dc 'a-zA-Z0-9' | head -c" # provide length

export PATH=~/scripts:~/go/bin:$PATH

PS1='[\u@\h \W]\$ '

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
. "$HOME/.cargo/env"


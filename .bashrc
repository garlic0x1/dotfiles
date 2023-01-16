#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ports='ss -ltnp'
alias emacs='emacsclient -c -a=edit'
alias doom='~/.emacs.d/bin/doom'
alias lisp='rlwrap sbcl'
alias clojure='rlwrap clojure'
alias ls='ls --color=auto'
alias edit='hx'
alias compose="sudo docker-compose"
alias zip="tar -zcvf" # archive, dir
alias unzip="tar -zxvf" # archive
alias keygen="cat /dev/urandom | tr -dc 'a-zA-Z0-9'" # alphanum hose

export PATH=~/scripts:~/go/bin:~/.roswell/bin:$PATH

PS1='[\u@\h \W]\$ '

[ -r /usr/share/bash-completion/bash_completion   ] && . /usr/share/bash-completion/bash_completion
. "$HOME/.cargo/env"

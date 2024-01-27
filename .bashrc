# .bashrc

# source global definitions
if [ -f /etc/bashrc ]; then . /etc/bashrc; fi

# vi mode
set -o vi

# pretty prompt
PS1='\n\u@\h (\w)\n~> '
PS2=' > '

# command history
hist () {
    if [ "$#" -eq 1 ]; then
	    history | cut -c 8- | grep $1;
    else
	    history | cut -c 8-;
    fi
}

# add to $PATH without dupes
add_path () {
    if [[ ":$PATH:" != *":$1:"* ]]; then
        export PATH="$PATH:$1"
    fi
}

alias dl-song='yt-dlp --extract-audio --audio-format flac --audio-quality 0'
  
# common aliases
alias lem-repl='lem --eval "(lem-lisp-mode:start-lisp-repl t)"'
alias vim='nvim'                                     # better editor
alias xmm='xmodmap ~/.xinitrc'                       # setup keybindings
alias keygen='cat /dev/urandom | tr -dc "a-zA-Z0-9"' # alphanum hose
alias ports='ss -lntp'                               # show open ports
alias path='echo $PATH | tr ":" "\n"'                # pretty path

# custom path
add_path "$HOME/go/bin"
add_path "$HOME/.qlot/bin"
add_path "$HOME/.local/bin"
add_path "$HOME/.cargo/bin"
add_path "$HOME/.mix/escripts"
add_path "$HOME/.config/emacs/bin"

# build jail
export CHROOT="$HOME/chroot"

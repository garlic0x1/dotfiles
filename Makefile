base:
	stow emacs -v
	stow sbcl
	stow tmux
	stow zsh
	stow x11 -v

clean:
	find . -type f -name '*.fasl' -delete
	find . -type f -name '*~' -delete

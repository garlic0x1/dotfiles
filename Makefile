base:
	stow emacs
	stow sbcl
	stow tmux
	stow zsh

clean:
	find . -type f -name '*.fasl' -delete
	find . -type f -name '*~' -delete

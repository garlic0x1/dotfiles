UNAME := $(shell uname)
PACKAGES := emacs fonts ghostty nvim provision sbcl tmux x11 zsh

stow:
	stow $(PACKAGES) -v

unstow:
	stow -D $(PACKAGES) -v

clean:
	find . -type f -name '*.fasl' -delete
	find . -type f -name '*~' -delete

tree:
	tree --gitignore -a -I .git

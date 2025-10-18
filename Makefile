UNAME := $(shell uname)
PACKAGES := emacs zsh tmux x11 sbcl provision fonts ghostty

stow:
	stow $(PACKAGES) -v

unstow:
	stow -D $(PACKAGES) -v

clean:
	find . -type f -name '*.fasl' -delete
	find . -type f -name '*~' -delete

tree:
	tree --gitignore -a -I .git

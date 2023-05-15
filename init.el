;; NOTE use openjdk:jdk instead of openjdk
;; guix packages
 ;; emacs
 ;; emacs-evil
 ;; emacs-doom-themes
 ;; emacs-guix
 ;; emacs-lispyville
 ;; emacs-cider
 ;; emacs-vterm
 ;; emacs-evil-collect
 ;; emacs-eshell-promp
 ;; emacs-restclient
 ;; emacs-restart-emac
 ;; emacs-magit
 ;; emacs-vertico
 ;; emacs-go-mode
 ;; emacs-lsp-mode
 ;; emacs-lsp-ui
 ;; emacs-company
 ;; emacs-company-lsp
 ;; emacs-company-posf
 ;; emacs-windower
 ;; emacs-eglot
 ;; emacs-undo-fu
 ;; emacs-clojure-mode

;; bigger font
(set-face-attribute 'default nil :height 130)

;; theme
(load-theme 'doom-palenight t)

;; make M-x nice
(vertico-mode)

;; code completion
(global-company-mode)
(setq company-minimum-prefix-length 1) 	; dont wait for 3 chars

;; get rid of clutter
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; set line numbers
(global-display-line-numbers-mode t)

;; evil mode
;; set up undo (needs to be before evil starts)
(setq evil-undo-system 'undo-fu)
(evil-mode)

;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; disable beeping
(setq ring-bell-function 'ignore)

;; eshell prompt
(with-eval-after-load "esh-opt"
  (autoload 'epe-theme-dakrone "eshell-prompt-extras")
  (setq eshell-highlight-prompt t
        eshell-prompt-function 'epe-theme-dakrone))

;; lispyville in scheme, elisp, and clojure modes
(add-hook 'scheme-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'emacs-lisp-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'clojure-mode-hook (lambda () (lispy-mode 1)))
(add-hook 'lispy-mode-hook (lambda () (lispyville-mode 1)))
(with-eval-after-load 'lispyville
  (lispyville-set-key-theme
   '((operators normal)
     c-w
     (prettify insert)
     (atom-movement normal visual)
     slurp/barf-lispy
     additional
     additional-insert)))

;; auto-generated, do not edit
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("5f128efd37c6a87cd4ad8e8b7f2afaba425425524a68133ac0efd87291d05874" "545ab1a535c913c9214fe5b883046f02982c508815612234140240c129682a68" default)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

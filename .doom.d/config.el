;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

(setq user-full-name "garlic0x1"
      user-mail-address "garlic1@protonmail.com"

      org-directory "~/org/"
      geiser-guile-load-path '("~/scheme")

      display-line-numbers-type t)

(set-face-attribute 'default nil :height 130) ; bigger font



;; random functions
(defun color-picker ()
  "run xcolor and yank result"
  (interactive)
  (let ((res (shell-command-to-string "xcolor")))
    (doom-print res)
    (kill-new res)))

(defun random-el (items)
  "random element of list"
  (let* ((size (length items))
         (index (random size)))
    (nth index items)))



;; choose a random theme at startup and expose functions for switching
(let ((known-themes '(doom-rouge
                      doom-palenight
                      doom-monokai-spectrum
                      doom-1337
                      doom-snazzy
                      modus-vivendi
                      deeper-blue
                      tango-dark
                      wombat
                      tsdh-dark
                      wheatgrass))

      (light-themes '(doom-flatwhite
                      doom-opera-light
                      doom-earl-grey
                      doom-gruvbox-light
                      modus-operandi
                      tsdh-light
                      ))

      (current-theme nil))

  (defun get-current-theme () (interactive) (print current-theme))

  (defun random-theme+ (themes)
    "set random theme from set"
    (let ((new-theme (random-el (remove current-theme themes))))
      (load-theme new-theme t)
      (setq current-theme new-theme)))  ;

  (defun random-theme ()
    "choose a random theme from all available themes"
    (interactive)
    (random-theme+ (custom-available-themes)))

  (defun random-known-theme ()
    "choose a random theme from whitelist"
    (interactive)
    (random-theme+ known-themes))

  (defun random-light-theme ()
    "choose a random light theme from whitelist"
    (interactive)
    (random-theme+ light-themes))

  (random-known-theme))



;; transparency controls
(let ((transparent? nil))
  (defun transparency (value)
    "Sets the transparency of the frame window. 0=transparent/100=opaque"
    (interactive "nTransparency Value 0 - 100 opaque:")
    (set-frame-parameter (selected-frame) 'alpha value))

  (defun toggle-transparency ()
    (interactive)
    (if transparent?
        (transparency 100)
        (transparency 70))
    (setq transparent? (not transparent?))))



;; personal key bindings
(map! :leader (:prefix ("d" . "garlic")
               :desc "toggle transprency" "t" #'toggle-transparency
               :desc "random known theme" "r" #'random-known-theme
               :desc "random light theme" "l" #'random-light-theme
               :desc "random theme"       "f" #'random-theme))

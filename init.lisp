;; -*- lisp -*-

(in-package :stumpwm)

(setf *mouse-focus-policy* :click
      *shell-program* (getenv "SHELL"))


;; a sequence of expressions to be
;; executed by xmodmap
(defvar xmodmap-commands
  '(;; make windows key bindable
    "clear mod4"
    "keycode 133 = F20"

    ;; make caps lock ctrl_l
    "remove Lock = Caps_Lock"
    "keysym Caps_Lock = Control_L"
    "add Control = Control_L"

    ;; make right shift caps_lock
    "remove Shift = Shift_R"
    "keysym Shift_R = Caps_Lock"
    "add Lock = Caps_Lock"))

;; apply custom keys
(mapcar
 (lambda (cmd)
   (run-shell-command (concatenate 'string "xmodmap -e '" cmd "'") t))
 xmodmap-commands)

;; background image
(run-shell-command "feh --bg-scale ~/.config/wallpaper")

;; windows key prefix
(set-prefix-key (kbd "F20"))

(set-module-dir
 (pathname-as-directory (concat (getenv "HOME") "/.guix-profile/share/common-lisp/sbcl")))

;; plugins
(load-module "winner-mode")
(load-module "swm-gaps")
(load-module "screenshot")
(load-module "pamixer")

;; set window gaps
(setf swm-gaps:*inner-gaps-size* 10
      swm-gaps:*outer-gaps-size* 10
      swm-gaps:*head-gaps-size* 0)

;; stuff to do first time
(when (null swm-gaps:*gaps-on*)
  (swm-gaps:toggle-gaps-on)
  (toggle-mode-line (current-screen) (current-head)))

(setf *screen-mode-line-format* "%d | %g | %v"
      *mode-line-position* :top)

;; bind dmenu
(defcommand dmenu () () (run-shell-command "dmenu_run"))

;; TODO need to permit light without password
(defcommand raise-brightness () () (run-shell-command "light -A 5"))
(defcommand lower-brightness () () (run-shell-command "light -U 5"))

(define-key *root-map* (kbd "d") "dmenu")

(define-key *top-map* (kbd "F1") "pamixer-toggle-mute")
(define-key *top-map* (kbd "F2") "pamixer-volume-down")
(define-key *top-map* (kbd "F3") "pamixer-volume-up")

(define-key *top-map* (kbd "F5") "lower-brightness")
(define-key *top-map* (kbd "F6") "raise-brightness")


;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.
(use-modules
 ;; base
 (gnu)
 (gnu system nss)
 (gnu packages vim)
 ;; (gnu packages gcc)
 ;; (gnu packages haskell)
 ;; (gnu packages lisp)
 ;; (gnu packages networking)
 ;; (gnu packages admin)
 ;; (gnu packages version-control)
 ;; browser
 (gnu packages gnuzilla)
 ;; (gnu packages fonts)
 ;; absolutely proprietary
 (nongnu packages linux)
 (nongnu system linux-initrd))
(use-service-modules desktop)
(use-package-modules bootloaders
                     gnome
                     lisp
                     haskell
                     gcc
                     vim
                     networking
                     admin
                     version-control
                     certs
                     fonts
                     screen
                     ssh
                     xorg
                     wm
		     rust-apps
                     suckless)

;; adjust brightness without sudo
(define %backlight-udev-rule
  (udev-rule
   "90-backlight.rules"
   (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/%k/brightness\""
                  "\n"
                  "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/%k/brightness\"")))

(define %nonguix/desktop-services
  (modify-services
   %desktop-services
   (guix-service-type
    config => (guix-configuration
	       (inherit config)
	       (substitute-urls
		(append (list "https://substitutes.nonguix.org")
			%default-substitute-urls))
	       (authorized-keys
		(append (list (local-file "/etc/signing-key.pub"))
			%default-authorized-guix-keys))))))

(operating-system

 ;; nonfree stuff
 (kernel linux)
 (initrd microcode-initrd)
 ;; includes intel wifi firmware
 (firmware (list linux-firmware))

 (host-name "cool.name")
 (timezone "America/Chicago")
 (locale "en_US.utf8")

 ;; see arch wiki
 (file-systems (append
                (list
                 (file-system
                  (device "/dev/sda1")
                  (mount-point "/boot/efi")
                  (type "vfat"))
                 (file-system
                  (device "/dev/sda3")
                  (mount-point "/")
                  (type "ext4")))
                %base-file-systems))

 ;; UEFI boot
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (targets '("/boot/efi"))))

 (users (cons (user-account
               (name "garlic")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video")))
              %base-user-accounts))

 (packages (append (list
                    openssh git gcc xterm ripgrep fd ;; utils
                    iwd wpa-supplicant		     ;; wifi tools
                    xmodmap sbcl stumpwm `(,stumpwm "lib")
                    gnome
                    vim	      ;; editors
                    nss-certs ;; for HTTPS access
                    )
                   %base-packages))

 (services %nonguix/desktop-services)

 ;; Allow resolution of '.localhttps://systemcrafters.cc/craft-your-system-with-guix/full-system-install/' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))

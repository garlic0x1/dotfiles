;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.
(use-modules
 ;; base
 (gnu)
 (gnu system nss)
 (gnu packages vim)
 (gnu packages networking)
 (gnu packages admin)
 ;; browser
 (gnu packages gnuzilla)
 (gnu packages fonts)
 ;; absolutely proprietary
 (nongnu packages linux)
 (nongnu system linux-initrd))
(use-service-modules desktop)
(use-package-modules bootloaders certs emacs emacs-xyz screen ssh xorg)

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
                  (device "/dev/sda2")
                  (mount-point "/var/swap"))
                 (type "btrfs")
                 (file-system
                  (device "/dev/sda3")
                  (mount-point "/")
                  (type "ext4")))
                %base-file-systems))

 ;; UEFI boot
 (bootloader (bootloader-configuration
              (bootloader grub-efi-bootloader)
              (target "/boot/efi")))

 ;; swap partition
 (swap-space
  (target "/var/swap"))

 (users (cons (user-account
               (name "garlic")
               (group "users")
               (supplementary-groups '("wheel" "netdev"
                                       "audio" "video")))
              %base-user-accounts))

 (packages (append (list
                    openssh git              ;; utils
                    emacs emacs-evil vim     ;; editors
		            iwd wpa-supplicant       ;; wifi tools
                    xterm                    ;; terminal emulators
                    icecat liberation-fonts  ;; browser
                    nss-certs                ;; for HTTPS access
                    )
                   %base-packages))

 ;; Use the "desktop" services, which include the X11
 ;; log-in service, networking with NetworkManager, and more.
 (services %desktop-services)

 ;; Allow resolution of '.localhttps://systemcrafters.cc/craft-your-system-with-guix/full-system-install/' host names with mDNS.
 (name-service-switch %mdns-host-lookup-nss))

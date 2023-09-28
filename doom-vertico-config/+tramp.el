;;; +tramp.el -*- lexical-binding: t; -*-

(use-package! tramp
  :defer-incrementally t
  :init
  (defvar my-auto-save-folder "~/.emacs-saves/"); folder for auto-saves
  ;;(setq tramp-terminal-type "xterm-256color") ;; setting this breaks sqlcl somehow; and possibly other things
  (setq tramp-completion-reread-directory-timeout 180
        tramp-default-method "ssh"
        tramp-password-prompt-regexp   ; Add verification code support.
        (concat
         "^.*"
         (regexp-opt
          '("passphrase" "Passphrase"
            "password" "Password"
            "Verification code"
            "RADIUS challenge")
          t)
         ".*:\0? *")
        tramp-auto-save-directory thsc/autosave-dir ; auto-save tramp files in local directory
        )
  ;; cache file-name forever
  (setq remote-file-name-inhibit-cache nil)

  ;; make sure vc stuff is not making tramp slower
  (setq vc-ignore-dir-regexp
        (format "%s\\|%s"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))

  ;; not sure why we have this? just cargo-culting from an answer I saw online.
  (setq tramp-verbose 1)
  ;; Below messes up fakecygpty cygwin ssh via tramp
  ;; (setq tramp-ssh-controlmaster-options
  ;;       (concat
  ;; ;;        ;; "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
  ;; ;;        ;;"-o ControlPath=/tmp/ssh-ControlPath/%%h:%%p "
  ;;        "-o ControlPath=~/.ssh/cm_socket/%%C "
  ;;        "-o ControlMaster=auto -o ControlPersist=yes"))
  (setq tramp-use-ssh-controlmaster-options nil)
  ;; projectile has the fun side-effect of wanting to calculate the project name, which makes tramp oh-so-much-slower.
  (setq projectile-mode-line "Projectile")
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  ;; (add-to-list 'tramp-default-proxies-alist
  ;;                                       ;'("\\.+atp.nchosting.dk" nil "/ssh:nc-jumpserver:"))
  ;;              '("\\." nil "/ssh:thsc@ssh.nchosting.dk:"))

  ;; (add-to-list 'tramp-default-proxies-alist
  ;;            '("\.*" nil "/ssh:nc-jumpserver:"))
  (add-to-list 'tramp-remote-process-environment "HISTSIZE=10000")
  (add-to-list 'tramp-remote-process-environment "HISTFILESIZE=10000")
  (add-to-list 'backup-directory-alist
               (cons tramp-file-name-regexp nil))
  (setq tramp-auto-save-directory (replace-regexp-in-string tramp-file-name-regexp "" thsc/autosave-dir)))

  ;;(add-to-list 'tramp-default-proxies-alist '("10.51.3.140" nil "/ssh:atp-fyp-shd01:"))

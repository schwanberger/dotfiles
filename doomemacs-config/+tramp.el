;;; +tramp.el -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Thomas Schwanberger
;;
;; Author: Thomas Schwanberger <thomas@schwanberger.dk>
;; Maintainer: Thomas Schwanberger <thomas@schwanberger.dk>
;; Created: March 22, 2024
;; Modified: March 22, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/thsc/+tramp
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;
;;
;;; Code:

(use-package! tramp
  :defer-incrementally t
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path) ; Add paths of remote at login time to tramp - why is not default?
  (setq tramp-default-method "ssh"
        tramp-use-ssh-controlmaster-options nil
        tramp-password-prompt-regexp   ; Add verification code support.
        (concat
         "^.*"
         (regexp-opt
          '("passphrase" "Passphrase"
            "password" "Password"
            "Verification code"
            "RADIUS challenge")
          t)
         ".*:\0? *"))
  (defun +thsc/oracle-login-shell ()
    "Open login shell as user oracle on host belonging to default-directory."
    (require 'tramp)
    (interactive)
    (if (string-match "su:oracle@" default-directory)
        (+thsc/bash)
      (let
          ((default-directory (thsc/oracle-file-path default-directory)))
        (+thsc/bash)))
    (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n(\$ORACLE_SID) $ '")
    )
  (defun thsc/oracle-file-path (file)
    (let ((host (or (file-remote-p file 'host) "localhost")))
      (concat "/" (when (file-remote-p file)
                    (concat (file-remote-p file 'method) ":"
                            (if-let (user (file-remote-p file 'user))
                                (concat user "@" host)
                              host)
                            "|"))
              "sudo:root@" "|" "su:oracle@" host
              ":" (or (file-remote-p file 'localname)
                      file))))
  (defun thsc/oracle-shell-this ()
    "Open shell as user oracle in this directory."
    (interactive)
    (if (string-match "su:oracle@" default-directory)
        (+thsc/bash)
      (let
          ((default-directory (thsc/oracle-file-path default-directory)))
        (+thsc/bash)))
    (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n(\$ORACLE_SID) $ '")
    )
  (add-to-list 'tramp-methods
               '("isudo"
                 (tramp-login-program "env")
                 (tramp-login-args
                  (
                   ("sudo")
                   ("-u" "%u")
                   ("--login")))
                 (tramp-remote-shell "/bin/bash")
                 (tramp-remote-shell-login
                  ("-l"))
                 (tramp-remote-shell-args
                  ("-c"))
                 (tramp-connection-timeout 10)
                 (tramp-session-timeout 300)
                 (tramp-password-previous-hop t))
               )
  )

(defun tramp-remote-dired (&optional arg)
  "Prompt for a remote host to connect to, and open an eshell
there."
  (require 'tramp)
  (interactive "p")
  (let*
      ((hosts
        (cl-reduce 'append
                   (mapcar
                    (lambda (x)
                      (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                    '((tramp-parse-sconfig "~/.ssh/config")))))
       (remote-host (completing-read "Remote host: " hosts)))
    (with-temp-buffer
      (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":/home"))
      (dired default-directory))))

(defun +thsc/remote-dired (&optional arg)
  "Prompt for a remote host to connect to, and open an eshell
there."
  (interactive "p")
  (require 'tramp)
  (let*
      ((hosts
        (cl-reduce 'append
                   (mapcar
                    (lambda (x)
                      (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                    '((tramp-parse-sconfig "~/.ssh/config")))))
       (remote-host (completing-read "Remote host: " hosts)))
    (with-temp-buffer
      (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":"))
      (dired default-directory))))

(defun +thsc/oracle-remote-login-shell ()
  "Open login shell as user oracle on remote host belonging to `default-directory`."
  (interactive)
  (require 'tramp)
  (unless (file-remote-p default-directory) (error "This function only works on remote hosts"))
  (let
                                        ;/ssh:atp-pev-ora01|sudo:oracle@
      ;; ((explicit-bash-args '("--noediting" "-l"))
      ;;  (explicit-shell-file-name "/bin/bash")
      ((default-directory (concat
                           "/ssh:"
                           (file-remote-p default-directory 'host)
                           "|isudo:oracle@:"
                           )))
                                        ;(shell))
    (shell (generate-new-buffer-name (format "shell %s"
                                             (concat
                                              default-directory
                                              "___"
                                              (sha1 (format "%s" (current-time))))
                                             ))))
  (auto-save-mode)
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n(\$ORACLE_SID) $ '")
  )

(provide '+tramp)
;;; +tramp.el ends here

;;  (add-to-list 'tramp-methods
;;               '("sudoer"
;;   (tramp-login-program "env")
;;   (tramp-login-args
;;    (("SUDO_PROMPT=P\"\"a\"\"s\"\"s\"\"w\"\"o\"\"r\"\"d\"\":")
;;     ("sudo")
;;     ("-u" "%u")
;;     ("-s")
;;     ("-H")
;;     ("%l")))
;;   (tramp-remote-shell "/bin/bash")
;;   (tramp-remote-shell-login
;;    ("-l"))
;;   (tramp-remote-shell-args
;;    ("-c"))
;;   (tramp-connection-timeout 10)
;;   (tramp-session-timeout 300)
;;   (tramp-password-previous-hop t)))

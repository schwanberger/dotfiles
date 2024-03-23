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
  (defun tramp-remote-dired (&optional arg)
    "Prompt for a remote host to connect to, and open an eshell
there."
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
  )

(provide '+tramp)
;;; +tramp.el ends here

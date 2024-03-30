;;; +shell.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Thomas Schwanberger
;;
;; Author: Thomas Schwanberger <thomas@schwanberger.dk>
;; Maintainer: Thomas Schwanberger <thomas@schwanberger.dk>
;; Created: March 22, 2024
;; Modified: March 22, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/thsc/+shell
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(add-hook! (shell-mode eshell-mode) (persp-add-buffer (current-buffer)))

(use-package! vterm
  :defer-incrementally t
  :config
  (setq vterm-kill-buffer-on-exit nil
        vterm-timer-delay 0.01)
  (add-hook! (shell-mode vterm-mode) (corfu-mode -1)) ;; auto-completion for vterm buffers should be handled by the shell
  (custom-set-faces!
    `(vterm-color-bright-black :foreground ,(doom-color 'comments)) ;; Fix zsh-autosuggestions being invisible in vterm buffers.
    `(vterm-color-bright-black :background ,(doom-color 'comments))) ;; Fix some (rare) ansible output being invisible in  vterm buffers.
  (remove-hook! '(vterm-mode-hook) #'hide-mode-line-mode))

(after! vterm
  (defun +thsc/paste-from-minibuffer-vterm()
    "An easy way to paste to vterm from clipholder program e.g.
'Ditto' when 'select-enable-clipboard' is nil"
    (interactive)
    (let ((select-enable-clipboard t)
          ;; (kill-ring nil) ; In case we do not want insertions into the kill-ring
          )
      (kill-new (format "%s" (read-from-minibuffer "Paste: ")))
      (vterm-yank)))
  (map!
   :map vterm-mode-map
   "C-c C-p" #'+thsc/paste-from-minibuffer-vterm)
  )


(defun +thsc/vterm ()
  "Create vterm shell. If on remote server, give the buffer a relevant name and
use bash as default shell."
  (require 'vterm)
  (interactive)
  (if
      (file-remote-p default-directory)
      (let ((vterm-shell "/bin/bash"))
        (vterm (generate-new-buffer-name (format "vterm %s" (concat (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time)))))))))
    (vterm (generate-new-buffer-name (format "vterm %s" (concat (format "%s" (read-from-minibuffer "Name: ")))))))
  (auto-save-mode))

(defun +thsc/vterm-bash ()
  "Create vterm shell. If on remote server, give the buffer a relevant name and
use bash as default shell."
  (require 'vterm)
  (interactive)
  (if
      (file-remote-p default-directory)
      (let ((vterm-shell "/bin/bash"))
        (vterm (generate-new-buffer-name (format "vterm %s" (concat (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time)))))))))
    (let ((vterm-shell (locate-file "bash" exec-path)))
      (vterm (generate-new-buffer-name (format "vterm %s" (concat (format "%s" (read-from-minibuffer "Name: "))))))))
  (auto-save-mode))

(defun +thsc/bash ()
  "Opens a bash shell buffer with the given name. If it's a remote
     shell, a unique name will be created for it."
  (interactive)

  (let ((shell-file-name (locate-file "bash" exec-path)))
    (shell (generate-new-buffer-name (format "shell %s" (concat
                                                         (if (file-remote-p default-directory)
                                                             (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                           (format "%s" (read-from-minibuffer "Name: "))
                                                           )))))
    (auto-save-mode)
    ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
    ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
    ;;(comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
    (comint-simple-send (current-buffer) "export PS1='[\\u@\\h:\\w] \\D{%F %T}\n$ '")
    ;;(comint-simple-send (current-buffer) "export PS1='\\D{%F %T}\n[\\u@\\h:\\w]$ '")
    ))

(defun +thsc/shell () ;; Shell is built-in no need to be lazy
  (interactive)
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n $ '"))

(provide '+shell)
;;; +shell.el ends here

;;; +defaults.el -*- lexical-binding: t; -*-

;; spell-check will be activated when needed, not before
(remove-hook! (org-mode markdown-mode TeX-mode rst-mode mu4e-compose-mode message-mode) #'flyspell-mode)

(after! corfu
  (setq corfu-auto nil ; You shell help when prompted (by TAB)
        +corfu-want-minibuffer-completion nil ; termianl minibuffer corfu completion leads to bad UX
        ))

; (fset 'epg-wait-for-status 'ignore) ; Disabled now that I'm not emacs 29.3 or newer version of gpg; Help emacs 29.1 with gpg save timeout with newer gnupg versions
(setq auth-sources '("~/.emacs_authinfo.gpg"))

(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                         ; Nobody likes to loose work, I certainly don't
      ;;select-enable-clipboard t                  ; OS clipboard integration
      select-enable-clipboard nil                  ; evil-mode shall not trash my clipboard
      password-cache-expiry nil
      kill-ring-max 50000
      kill-do-not-save-duplicates t
      display-time-24hr-format t
      ;;battery-mode-line-format "[%b%p\%] "
      ;;battery-mode-line-format "[%b] "
      company-idle-delay nil)

(display-battery-mode 1)                          ; Show battery, not useful if not laptop
(display-time-mode 1)
(prefer-coding-system 'utf-8-unix)

(after! yaml-mode
  (def-project-mode! +ansible-yaml-mode
    :modes '(yaml-mode)
    :add-hooks '(ansible ansible-auto-decrypt-encrypt ansible-doc-mode)
    :files (or "roles/" "tasks/main.yml" "tasks/main.yaml" "playbooks"))
  )

(after! evil
  (setq evil-vsplit-window-right t
        evil-split-window-below t)
  (defadvice! prompt-for-buffer (&rest _)
    :after '(evil-window-split evil-window-vsplit)
    (consult-buffer))

  (map!
   :n "H" #'evil-window-left
   :n "J" #'evil-window-down
   :n "K" #'evil-window-up
   :n "L" #'evil-window-right
   ))

(after! magit
(add-hook! 'magit-process-find-password-functions
          'magit-process-password-auth-source)
)

(global-set-key [remap dabbrev-expand] #'hippie-expand)

(setq hippie-expand-try-functions-list
      '(try-expand-list
        try-expand-dabbrev-visible
        try-expand-dabbrev
        try-expand-all-abbrevs
        try-expand-dabbrev-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-dabbrev-from-kill
        try-expand-whole-kill
        try-expand-line
        try-complete-lisp-symbol-partially
        try-complete-lisp-symbol))

(when (getenv "WSLENV")
  (defun wsl-copy (start end)
    (interactive "r")
    (shell-command-on-region start end "clip.exe")
    (deactivate-mark))

  (defun wsl-paste ()
    (interactive)
    (let ((clipboard
           (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
      (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters
      (setq clipboard (substring clipboard 0 -1)) ; Remove newline added by Powershell
      (insert clipboard)))

  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic)))

  (after! org
    ;; Make http(s) links in org mode open in Windows on RET
    (dolist (scheme '("ftp" "http" "https" "mailto" "news"))
      (org-link-set-parameters scheme
                               :follow
                               (lambda (url arg)
                                 (browse-url-generic (concat scheme ":" url) arg))))))

;;; +defaults.el -*- lexical-binding: t; -*-

;; Tweaked defaults
(global-subword-mode 1)                           ; Iterate through CamelCase words
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



;; WSL experience improvement
(when (getenv "WSLENV")
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))

(defun wsl-paste ()
  (interactive)
  (let ((clipboard
         (shell-command-to-string "powershell.exe -command 'Get-Clipboard' 2> /dev/null")))
    (setq clipboard (replace-regexp-in-string "\r" "" clipboard)) ; Remove Windows ^M characters
    (setq clipboard (substring clipboard 0 -1)) ; Remove newline added by Powershell
    (insert clipboard)))

(setq completion-category-overrides '((file (styles basic-remote orderless))))

(use-package! clean-kill-ring
  :defer-incrementally t
  :config
  (setq clean-kill-ring-prevent-duplicates t)
  (clean-kill-ring-mode))

(use-package! hl-todo
  :hook ((org-mode . hl-todo-mode)
         (org-mode . (lambda ()
                       (setq-local hl-todo-highlight-punctuation ":"
                                   hl-todo-keyword-faces
                                   `(("FIXME"      error bold)
                                     ("HACK"       font-lock-constant-face bold)
                                     ("REVIEW"     font-lock-keyword-face bold)
                                     ("NOTE"       warning bold)
                                     ("DEPRECATED" font-lock-doc-face bold)))))))

(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

;; writegood-mode will be activated when needed, not before
(remove-hook! (org-mode markdown-mode rst-mode asciidoc-mode latex-mode LaTeX-mode) #'writegood-mode)


;; spell-check will be activated when needed, not before
(remove-hook! (org-mode markdown-mode TeX-mode rst-mode mu4e-compose-mode message-mode) #'flyspell-mode)

;; ; Nicer navigation of huge files
;; (use-package! vlf-setup
;;   :defer-incrementally t
;;   )

(add-to-list 'load-path "~/doom-vertico-config/snippets")

(setq current-iso639-language 'en)
;;
;; System locale to use for formatting time values.
(setq system-time-locale "C")         ; Make sure that the weekdays in the
                                        ; time stamps of your Org mode files and
                                        ; in the agenda appear in English.


(use-package! olivetti
  :after org
  ;; :custom
  ;; ;(olivetti-body-width 120) ; 2024-01-09 back to defaults, in line with semantic line breaks: https://sembr.org/
  )

(fset 'epg-wait-for-status 'ignore) ; Help emacs 29.1 with gpg save timeout with newer gnupg versions
(setq auth-sources '(password-store "~/.emacs_authinfo.gpg"))
(setq magit-process-find-password-functions '(magit-process-password-auth-source))

(require 'auth-source-pass)
(add-hook 'magit-process-find-password-functions
          'magit-process-password-auth-source)
(setq gitlab.user "admin_thsc")
(setq gitlab.nchosting.dk.user "admin_thsc")

(with-eval-after-load 'forge
  (add-to-list 'forge-alist
               '("gitlab.nchosting.dk"
                 "gitlab.nchosting.dk/api/v4"
                 "gitlab.nchosting.dk"
                 forge-gitlab-repository)))


(use-package! ef-themes
  :defer-incrementally t)

(use-package! modus-themes
  :defer-incrementally t
  ;; :init
  ;; (setq modus-themes-italic-constructs t
  ;;       modus-themes-bold-constructs t
  ;;       modus-themes-mixed-fonts nil
  ;;       modus-themes-variable-pitch-ui nil
  ;;       modus-themes-custom-auto-reload t
  ;;       modus-themes-org-blocks 'gray-background)
  ;; :config
  ;; ;;(setq modus-themes-common-palette-overrides modus-themes-preset-overrides-intense)
  ;; (setq modus-themes-common-palette-overrides modus-themes-preset-overrides-faint)
  )

(after! corfu
  (setq corfu-auto nil ; You shell help when prompted (by TAB)
        +corfu-want-minibuffer-completion nil ; termianl minibuffer corfu completion leads to bad UX
        )
  )

  ;;;; LSP
;; (unless (modulep! :checkers syntax)
;;   (setq lsp-diagnostics-provider :flymake))
;; (after! lsp-mode
;;   (setq
;;    lsp-auto-guess-root t
;;    lsp-enable-semantic-tokens-enable nil
;;    lsp-progress-via-spinner nil
;;    lsp-idle-delay 0.47
;;    lsp-completion-enable-additional-text-edit nil
;;    lsp-signature-render-documentation t
;;    lsp-signature-auto-activate t
;;    lsp-signature-doc-lines 5
;;    lsp-eldoc-enable-hover t
;;    lsp-headerline-breadcrumb-enable t
;;    lsp-enable-indentation t
;;    lsp-enable-on-type-formatting nil
;;    lsp-enable-symbol-highlighting nil
;;    lsp-enable-links nil
;;    lsp-log-io nil))

;; (setq +lsp-company-backends '(company-capf :with company-yasnippet))

;; (after! lsp-ui
;;   (setq lsp-ui-sideline-enable t
;;         lsp-ui-sideline-show-code-actions t
;;         lsp-ui-sideline-show-symbol nil
;;         lsp-ui-sideline-show-hover nil
;;         lsp-ui-sideline-show-diagnostics nil
;;         lsp-ui-doc-enable t
;;         lsp-ui-doc-position 'top
;;         lsp-ui-doc-delay 0.73
;;         lsp-ui-doc-max-width 50
;;         lsp-ui-doc-max-height 15
;;         lsp-ui-doc-include-signature t
;;         lsp-ui-doc-header t)

;;   (add-hook! 'lsp-ui-mode-hook
;;     (run-hooks (intern (format "%s-lsp-ui-hook" major-mode)))))

;; ;;;;; Flycheck
;; (after! flycheck
;;   (setq flycheck-display-errors-delay 0.1))


;; ;; (use-package! pyenv-mode
;; ;;   :init
;; ;;   (add-to-list 'exec-path "~/.pyenv/shims")
;; ;;   (setenv "WORKON_HOME" "~/.pyenv/versions/")
;; ;;   :config
;; ;;   (pyenv-mode))

(setq pyenv-mode-mode-line-format nil)

(use-package! lambda-themes
  :defer-incrementally t
  ;; :custom
  ;; (lambda-themes-set-italic-comments nil)
  ;; (lambda-themes-set-italic-keywords nil)
  ;; (lambda-themes-set-variable-pitch nil)
  )

(use-package! standard-themes
  :defer-incrementally t
  )


(defun +thsc/paste-from-minibuffer()
  "An easy way to paste from clipholder program e.g.
'Ditto' when 'select-enable-clipboard' is nil"
  (interactive)
  (let ((select-enable-clipboard t))
    (setcar kill-ring (format "%s" (read-from-minibuffer "Paste: ")))
    (yank)))

(defun +thsc/paste-from-minibuffer-vterm()
  "An easy way to paste to vterm from clipholder program e.g.
'Ditto' when 'select-enable-clipboard' is nil"
  (interactive)
  (let ((select-enable-clipboard t))
    (setcar kill-ring (format "%s" (read-from-minibuffer "Paste: ")))
    (vterm-yank)))

(map! "C-c C-p" #'+thsc/paste-from-minibuffer)

(defun +thsc/yank-to-clipboard (beg end &optional region)
  ;; Pass mark first, then point, because the order matters when
  ;; calling `kill-append'.
  (interactive (list (mark) (point) 'region))
  (let ((select-enable-clipboard t))
    (copy-region-as-kill beg end region))
  ;; This use of called-interactively-p is correct because the code it
  ;; controls just gives the user visual feedback.
  (if (called-interactively-p 'interactive)
      (indicate-copied-region)))

(map! :leader
      (:prefix-map ("y" . "Yank helpers")
       :desc "Yank it to system clipboard, please" "y" #'+thsc/yank-to-clipboard))

(map! :leader
      (:prefix-map ("F" . "Switch to next frame")
       :desc "Change active frame, skipping Windows entirely." "F" #'+evil/next-frame))


(defun uniquify-region-lines (beg end)
  "Remove duplicate adjacent lines in region."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
      (replace-match "\\1"))))

(defun uniquify-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))

;; (defun uniquify-u (list)
;;   "Return a copy of LIST with all non-unique elements removed."
;;   (let ((table (make-hash-table :test 'equal)))
;;     (cl-loop for string in list do
;; 	     (puthash string (1+ (gethash string table 0))
;; 		      table))
;;     (cl-loop for key being the hash-keys of table
;; 	     unless (> (gethash key table) 1)
;; 	     collect key)))

;; (defun uniquify-u (buffer)
;;   (interactive)
;;   "Return a copy of LIST with all non-unique elements removed."
;;   (let ((table (make-hash-table :test 'equal)))
;;     (cl-loop for string in buffer do
;; 	     (puthash string (1+ (gethash string table 0))
;; 		      table))
;;     (cl-loop for key being the hash-keys of table
;; 	     unless (> (gethash key table) 1)
;; 	     collect key)))

(defun uniquify-u-region-lines (beg end)
  "Remove duplicate adjacent lines in region."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(.*\n\\)\\1+" end t)
      (replace-match ""))))

(defun uniquify-u-buffer-lines ()
  "Remove duplicate adjacent lines in the current buffer."
  (interactive)
  (uniquify-region-lines (point-min) (point-max)))

                                        ; Proper tab with for Oracle Sqlplus
(setq-default tab-width 8)

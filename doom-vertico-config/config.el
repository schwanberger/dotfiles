;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

(setq user-full-name "Thomas Schwanberger"
      user-mail-address "thomas@schwanberger.dk")

;;(setq doom-font (font-spec :family "Iosevka" :size 17 :weight 'light)
;;(setq doom-font (font-spec :family "Iosevka Comfy" :size 17 :weight 'light)
;;(setq doom-font (font-spec :family "Iosevka Comfy" :height 120 :weight 'regular) ;; Height has no effect on Windows
;;(setq doom-font (font-spec :family "Iosevka Comfy" :size 16 :weight 'regular)
;;
;;
;;
;;
;;
;;(set-face-attribute 'default nil :font "Iosevka Comfy" :height 110 :weight 'regular)
;;(set-face-attribute 'default nil :font "Iosevka Comfy" :height 115 :weight 'regular)

;;(ignore-errors
;;;;(setq doom-font (font-spec :family "Iosevka Comfy" :size 12.0 :weight 'light)
(setq doom-font (font-spec :family "Victor Mono" :size 12.0 :weight 'semi-light))
;;;;(setq doom-font (font-spec :family "JetBrains Mono" :size 12.0 :weight 'semi-light)
;;;;(setq doom-font (font-spec :family "Iosevka" :size 14.0 :weight 'semi-light)
;;;;(setq doom-font (font-spec :family "Iosevka" :size 12.0 :weight 'Light)
;;      ;;doom-variable-pitch-font (font-spec :family "Alegreya Sans")
;;      ;;doom-variable-pitch-font (font-spec :family "Roboto" :style "Regular" :weight 'light)
;;      doom-variable-pitch-font (font-spec :family "FiraGO" :weight 'regular)
;;      ;;ivy-posframe-font (font-spec :family "Iosevka")
;;      ))

;;(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 10 :weight 'light))
;;(setq doom-font (font-spec :family "DejaVu Sans Mono" :size 10.0 :weight 'regular))

;;(setq doom-font (font-spec :family "Victor Mono" :size 15 :weight 'regular)
;;(setq doom-font (font-spec :family "Iosevka Comfy" :size 15 :weight 'semi-light)
 ;;     doom-variable-pitch-font (font-spec :family "Alegreya" :size 18))
;; (use-package! doom-themes
;;   :defer-incrementally t
;;   :config
;;   (setq doom-gruvbox-dark-variant "hard")
;;   )

;; (after! solaire-mode
;;   (add-to-list 'solaire-mode-themes-to-face-swap "^doom-")
;;   )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

;; (use-package! modus-themes
;;   :defer-incrementally t
;;   :init
;;   (setq modus-themes-org-blocks 'gray-background
;;         modus-themes-bold-constructs t
;;         modus-themes-italic-constructs t
;;         ;;modus-themes-deuteranopia t
;;         ;;modus-themes-syntax '(faint alt-syntax)
;;         ;;modus-themes-syntax '(green-strings alt-syntax)
;;         ;;modus-themes-syntax '(green-strings)
;;         ;;modus-themes-syntax '(faint green-strings)
;;         ;;modus-themes-syntax '(alt-syntax green-strings yellow-comments)
;;         modus-themes-syntax '(green-strings yellow-comments)
;;         ;; modus-themes-syntax '(faint alt-syntax green-strings yellow-comments)
;;         )
;;   (modus-themes-load-themes)
;;   )

;;LETS TRY
;; (add-hook! 'modus-themes-after-load-theme-hook
;;   (defun my-modus-themes-custom-faces ()
;;     (modus-themes-with-colors
;;       (custom-set-faces
;;        ;;",class" found by looking into modus-theme source code in .../straight...
;;        `(org-quote ((,class :slant italic)))
;;        ;; Only these two needs to be defined for mixed-pitch-mode working in both states
;;        `(default ((nil (,doom-font))))
;;        `(fixed-pitch ((nil (,doom-font))))
;;        )
;;       )
;;     )
;;   )

;;LETS TRY
;; (use-package! modus-themes
;;   :defer-incrementally t
;;   :init
;;   ;; Add all your customizations prior to loading the themes
;;   (setq modus-themes-italic-constructs t
;;         modus-themes-completions '((matches . (background intense))
;;                                    (selection . (accented intense))
;;                                    (popup . (accented intense)))
;;         ;; modus-themes-variable-pitch-headings t
;;         modus-themes-scale-headings t
;;         ;; modus-themes-variable-pitch-ui t
;;         modus-themes-org-agenda
;;         '((header-block . (variable-pitch scale-title))
;;           (header-date . (grayscale bold-all)))
;;         modus-themes-org-blocks
;;         'gray-background
;;         modus-themes-mode-line
;;         '(borderless)
;;         ;; modus-themes-mixed-fonts t
;;         ;; modus-themes-subtle-line-numbers t

;;         modus-themes-region '(bg-only no-extend))

;;   ;; Load the theme files before enabling a theme
;;   (modus-themes-load-themes)
;;   :config
;;   (modus-themes-load-operandi)
;;   )

(setq doom-theme 'doom-vibrant
      doom-themes-treemacs-theme 'doom-colors
      doom-acario-dark-brighter-modeline t
      doom-acario-light-brighter-modeline t
      doom-nohl-light-brighter-comments t
      doom-nohl-dark-brighter-comments t)

(use-package! modus-themes
  :init
  (setq modus-themes-inhibit-reload t
        ;;modus-themes-syntax '(faint green-strings alt-syntax yellow-comments)
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        modus-themes-prompts '(intense bold)
        modus-themes-completions '((matches . (extrabold intense))
                                   (selection . (semibold accented intense underline))
                                   (popup . (accented)))
        modus-themes-paren-match '(intense underline)))

  ;;;; LSP
(unless (featurep! :checkers syntax)
  (setq lsp-diagnostics-provider :flymake))
(after! lsp-mode
  (setq
   lsp-auto-guess-root t
   lsp-enable-semantic-tokens-enable nil
   lsp-progress-via-spinner nil
   lsp-idle-delay 0.47
   lsp-completion-enable-additional-text-edit nil
   lsp-signature-render-documentation t
   lsp-signature-auto-activate t
   lsp-signature-doc-lines 5
   lsp-eldoc-enable-hover t
   lsp-headerline-breadcrumb-enable t
   lsp-enable-indentation t
   lsp-enable-on-type-formatting nil
   lsp-enable-symbol-highlighting nil
   lsp-enable-links nil
   lsp-log-io nil))

(setq +lsp-company-backends '(company-capf :with company-yasnippet))

(after! lsp-ui
  (setq lsp-ui-sideline-enable t
        lsp-ui-sideline-show-code-actions t
        lsp-ui-sideline-show-symbol nil
        lsp-ui-sideline-show-hover nil
        lsp-ui-sideline-show-diagnostics nil
        lsp-ui-doc-enable t
        lsp-ui-doc-position 'top
        lsp-ui-doc-delay 0.73
        lsp-ui-doc-max-width 50
        lsp-ui-doc-max-height 15
        lsp-ui-doc-include-signature t
        lsp-ui-doc-header t)

  (add-hook! 'lsp-ui-mode-hook
    (run-hooks (intern (format "%s-lsp-ui-hook" major-mode)))))

;;;;; Flycheck
(after! flycheck
  (setq flycheck-display-errors-delay 0.1))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

(setq select-enable-clipboard t)

;; Backup and autosave revamp
(defvar thsc/backup-location (expand-file-name "~/.emacs-saves")
  "Base directory for backup files.")
(defvar thsc/eshell-dir (expand-file-name "~/.emacs-saves/eshell")
  "Directory for eshell related backup/autosave/history.")
(defvar thsc/backup-dir (expand-file-name "~/.emacs-saves/backup"))
(defvar thsc/autosave-dir (expand-file-name "~/.emacs-saves/autosave"))
(defvar thsc/autosave-dir-nonfile (expand-file-name "~/.emacs-saves/autosave_nonfile"))

(make-directory thsc/backup-location t)
(make-directory thsc/eshell-dir t)
(make-directory thsc/backup-dir t)
(make-directory thsc/autosave-dir t)
(make-directory thsc/autosave-dir-nonfile t)

(defun auto-save-file-name-p (filename) (string-match "^#.*#$" (file-name-nondirectory filename)))
(defun make-auto-save-file-name ()
  (if buffer-file-name (concat thsc/autosave-dir "/" "#" (file-name-nondirectory buffer-file-name) "#")
    ;;(expand-file-name (concat thsc/autosave-dir-nonfile "/" (format-time-string "%y_%m_%d") (format "%s" (shell-command "uuidgen" t)) "#%"
    (expand-file-name (concat thsc/autosave-dir-nonfile "/" (format-time-string "%y_%m_%d") "#%"
                              (replace-regexp-in-string "[*]\\|/" "" (buffer-name)) "_" (sha1 (format "%s" (current-time))) "#"))))
;;                              (replace-regexp-in-string "[*]\\|/" "" (buffer-name)) (sha1 buffer-name) "#"))))


(defadvice! thsc/make-backup-file-name (fn FILE)
  :around #'make-backup-file-name-1
  (let ((dirname (concat thsc/backup-dir
                         (format-time-string "/%y/%m/%d/"))))
    (if (not (file-exists-p dirname))
        (make-directory dirname t))
    (concat dirname (file-name-nondirectory FILE))))

(advice-remove 'make-backup-file-name-1 'doom-make-hashed-backup-file-name-a)
(advice-remove 'make-auto-save-file-name 'doom-make-hashed-auto-save-file-name-a)

(setq
 make-backup-files t
 backup-by-copying t     ; don't clobber symlinks
 kept-new-versions 10    ; keep 10 latest versions
 kept-old-versions 0     ; don't bother with old versions
 delete-old-versions t   ; don't ask about deleting old versions
 version-control t       ; number backups
 vc-make-backup-files t  ; backup version controlled files
 savehist-file (concat thsc/backup-location "/" "savehist")
 history-delete-duplicates t
 history-length t
 eshell-history-file-name (concat thsc/eshell-dir "/" "history")
 backup-directory-alist
 `((".*" . ,thsc/backup-dir))
 auto-save-file-name-transforms
 `((".*" ,thsc/autosave-dir t)))
;;

(after! org
  (load! "+org"))

;; (after! org
;;   (require 'org-indent)
;;   ;;(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org"))
;;   ;; Should have agenda view that shows only work related and a view that shows both work and private
;;   ;; The "scheduled only view" should show both
;;   (setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/private/practical.org"))
;;   ;; Linebreaks: WYSISYG
;;   (setq org-export-preserve-breaks t)
;;   ;; Disable eval on export by default
;;   (setq org-export-babel-evaluate nil)
;;   (setq org-pandoc-options-for-docx `(
;;                                       ;;(reference-doc . "C:/Projects/todo/pandoc/nc_ref.docx")
;;                                       ;;(reference-doc . "~/org/todo/pandoc/nc_ref.docx")
;;                                       ;;(reference-doc . "/c/Users/thsc/Desktop/nc_ref2.docx")
;;                                       ;;(reference-doc . "C:/Users/thsc/Desktop/nc_ref2.docx")
;;                                       (reference-doc . ,(expand-file-name "~/Desktop/nc_ref2.docx"))
;;                                       ))

;;   (setq org-pandoc-options-for-html5 `(
;;                                        (number-sections . t)
;;                                        (toc . t)
;;                                        (self-contained . t)
;;                                        ;;(template . "C:/Projects/todo/easy_template.html")
;;                                        (template . ,(expand-file-name "~/org/todo/pandoc/html5/github/GitHub.html5"))
;;                                        ;;(template . "C:/Projects/todo/pandoc/html5/kjhealy/html.template")
;;                                        ))

;;   ;; (setq org-pandoc-options-for-latex-pdf '(
;;   ;;                                          (number-sections . t)
;;   ;;                                          (toc . t)
;;   ;;                                          (template . "C:/Projects/todo/eisvogel.tex")
;;   ;;                                          (pdf-engine . "lualatex")
;;   ;;                                          ))
;;   (setq org-pandoc-options-for-markdown '(
;;                                           (toc . t)
;;                                           ))
;;   (setq org-pandoc-options-for-gfm '(
;;                                      (toc . t)
;;                                      ))
;;   (require 'org-id)
;;   (setq org-use-property-inheritance t
;;         org-log-done 'time ; matches behaviour of orgzly
;;         org-log-into-drawer t
;;         org-list-allow-alphabetical t
;;         org-export-in-background t
;;         org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
;;         org-id-link-to-org-use-id 'create-if-interactive
;;         )
;;   (setq org-clock-persist t)
;;   (org-clock-persistence-insinuate)


;;   (use-package! org-pandoc-import
;;     :defer-incrementally t)
;;   ;; Don't break evil navigation in org-super-agenda
;;   (setq org-super-agenda-header-map 'evil-org-agenda-mode-map)
;;   (setq org-catch-invisible-edits 'smart
;;         ;;org-export-with-sub-superscripts '{}
;;         org-export-with-sub-superscripts nil
;;         org-hide-emphasis-markers t
;;         org-ellipsis " ▾ "
;;         )


;;   ;; Trying out the latest and greatest GTD, therefore this should be commented out
;;   ;; (load! "+org")
;;   )
;; Add icons to modeline
(after! doom-modeline (setq doom-modeline-major-mode-icon t))

(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t)                        ; Nobody likes to loose work, I certainly don't

;; [2022-02-14 Mon] Have uncommented most lines here, am unsure if necessary
;; (setq locale-coding-system 'utf-8-unix)
;; (set-terminal-coding-system 'utf-8-unix)
;; (set-keyboard-coding-system 'utf-8-unix)
;; (set-selection-coding-system 'utf-8-unix)
;;;(setq selection-coding-system 'iso-latin-1-unix)
(prefer-coding-system 'utf-8-unix)

;; 2013-12-10 IRC #Emacs
;; [2022-02-14 Mon] Windows c/p issues fixed with this
;; TODO create os pcase block for this to only allow on windows
(set-clipboard-coding-system 'iso-latin-1-unix)

;; http://www.masteringemacs.org/articles/2012/08/09/working-coding-systems-unicode-emacs/
;; in addition to the lines above:

;;(set-default-coding-systems 'utf-8-unix)
;; backwards compatibility as default-buffer-file-coding-system
;; ;; is deprecated in 23.2.
;; (if (boundp 'buffer-file-coding-system)
;;     (setq-default buffer-file-coding-system 'utf-8-unix)
;;   (setq default-buffer-file-coding-system 'utf-8-unix))
;; ;; Treat clipboard input as UTF-8-UNIX string first; compound text next, etc.
;; (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Emacs on WSL open links in Windows web browser
;; https://adam.kruszewski.name/2017/09/emacs-in-wsl-and-opening-links/
(when (getenv "WSLENV")
  (let ((cmd-exe "/mnt/c/Windows/System32/cmd.exe")
        (cmd-args '("/c" "start")))
    (when (file-exists-p cmd-exe)
      (setq browse-url-generic-program  cmd-exe
            browse-url-generic-args     cmd-args
            browse-url-browser-function 'browse-url-generic
            search-web-default-browser 'browse-url-generic))))

(use-package! groovy-mode
  :defer-incrementally t
  :config
  (setq groovy-indent-offset 4))
(setq comint-input-ring-size 5000)
(setq plantuml-default-exec-mode 'jar)
(setq org-id-extra-files '(
                           (org-agenda-text-search-extra-files)
                           (directory-files-recursively "/home/vagrant/org" "org$")
                           )
      )

(setq password-cache-expiry nil)

;; (use-package! sqlplus
;;   :defer-incrementally t)
(use-package! tramp
  :defer-incrementally t
  :init
  (defvar my-auto-save-folder "~/.emacs-saves/"); folder for auto-saves
  (setq tramp-terminal-type "xterm-256color")
  (setq tramp-completion-reread-directory-timeout 180
        tramp-default-method "ssh"
        tramp-password-prompt-regexp   ; Add verification code support.
        (concat
         "^.*"
                  ;; "^\\(.*\\n?\\)*"
         (regexp-opt
          '("passphrase" "Passphrase"
            "password" "Password"
            "Verification code"
            "RADIUS challenge")
          t)
         ".*:\0? *")
        ;;tramp-auto-save-directory my-auto-save-folder ; auto-save tramp files in local directory
        tramp-auto-save-directory thsc/autosave-dir ; auto-save tramp files in local directory
        )
  ;; cache file-name forever
  (setq remote-file-name-inhibit-cache nil)

  ;; make sure vc stuff is not making tramp slower
  (setq vc-ignore-dir-regexp
        (format "%s\\|%s"
                vc-ignore-dir-regexp
                tramp-file-name-regexp))

  ;; not sure why we have this? just cargo-culting from an answer I saw
  ;; online.
  (setq tramp-verbose 1)
  ;; Below messes up fakecygpty cygwin ssh via tramp
  ;; (setq tramp-ssh-controlmaster-options
  ;;       (concat
  ;; ;;        ;; "-o ControlPath=/tmp/ssh-ControlPath-%%r@%%h:%%p "
  ;; ;;        ;;"-o ControlPath=/tmp/ssh-ControlPath/%%h:%%p "
  ;;        "-o ControlPath=~/.ssh/cm_socket/%%C "
  ;;        "-o ControlMaster=auto -o ControlPersist=yes"))
  (setq tramp-use-ssh-controlmaster-options nil)
  ;; projectile has the fun side-effect of wanting to calculate the
  ;; project name, which makes tramp oh-so-much-slower.
  (setq projectile-mode-line "Projectile")
  :config
  (add-to-list 'tramp-remote-path 'tramp-own-remote-path)
  (add-to-list 'tramp-default-proxies-alist
                                        ;'("\\.+atp.nchosting.dk" nil "/ssh:nc-jumpserver:"))
               '("\\.+nchosting.dk" nil "/ssh:nc-jumpserver:"))
  (add-to-list 'tramp-remote-process-environment "HISTSIZE=10000")
  (add-to-list 'tramp-remote-process-environment "HISTFILESIZE=10000")
  ;; (add-to-list 'backup-directory-alist
  ;;              (cons tramp-file-name-regexp thsc/backup-dir))
  (add-to-list 'backup-directory-alist
               (cons tramp-file-name-regexp nil))
  ;;(setq tramp-auto-save-directory nil)
  (setq tramp-auto-save-directory (replace-regexp-in-string tramp-file-name-regexp "" thsc/autosave-dir))
  )

(use-package! org-appear
  :defer-incrementally t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))

;;ESHELL TWEAKS
(defun eshell-exec-visual (&rest args)
  "Run the specified PROGRAM in a terminal emulation buffer.
 ARGS are passed to the program.  At the moment, no piping of input is
 allowed."
  (let* (eshell-interpreter-alist
         (original-args args)
         (interp (eshell-find-interpreter (car args) (cdr args)))
         (in-ssh-tramp (and (tramp-tramp-file-p default-directory)
                            (equal (tramp-file-name-method
                                    (tramp-dissect-file-name default-directory))
                                   "ssh")))
         (program (if in-ssh-tramp
                      "ssh"
                    (car interp)))
         (args (if in-ssh-tramp
                   (let ((dir-name (tramp-dissect-file-name default-directory)))
                     (eshell-flatten-list
                      (list
                       "-t"
                       (tramp-file-name-host dir-name)
                       (format
                        "export TERM=xterm-256color; cd %s; exec %s"
                        (tramp-file-name-localname dir-name)
                        (string-join
                         (append
                          (list (tramp-file-name-localname (tramp-dissect-file-name (car interp))))
                          (cdr args))
                         " ")))))
                 (eshell-flatten-list
                  (eshell-stringify-list (append (cdr interp)
                                                 (cdr args))))))
         (term-buf
          (generate-new-buffer
           (concat "*"
                   (if in-ssh-tramp
                       (format "%s %s" default-directory (string-join original-args " "))
                     (file-name-nondirectory program))
                   "*")))
         (eshell-buf (current-buffer)))
    (save-current-buffer
      (switch-to-buffer term-buf)
      (term-mode)
      (set (make-local-variable 'term-term-name) eshell-term-name)
      (make-local-variable 'eshell-parent-buffer)
      (setq eshell-parent-buffer eshell-buf)
      (term-exec term-buf program program nil args)
      (let ((proc (get-buffer-process term-buf)))
        (if (and proc (eq 'run (process-status proc)))
            (set-process-sentinel proc 'eshell-term-sentinel)
          (error "Failed to invoke visual command")))
      (term-char-mode)
      (if eshell-escape-control-x
          (term-set-escape-char ?\C-x))))
  nil)
(setq eshell-history-size 1000000)

;; (setq comint-output-filter-functions
;;       (remove 'ansi-color-process-output comint-output-filter-functions))

;; (add-hook 'shell-mode-hook
;;           (lambda ()
;;             ;; Disable font-locking in this buffer to improve performance
;;             (font-lock-mode -1)
;;             ;; Prevent font-locking from being re-enabled in this buffer
;;             (make-local-variable 'font-lock-function)
;;             (setq font-lock-function (lambda (_) nil))
;;             (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))

(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;
;; IMO, modern editors have trained a bad habit into us all: a burning need for
;; completion all the time -- as we type, as we breathe, as we pray to the
;; ancient ones -- but how often do you *really* need that information? I say
;; rarely. So opt for manual completion:
(setq company-idle-delay nil)

;; ;;Autosave-tests
;; (setq backup-by-copying t      ; don't clobber symlinks
;;       backup-directory-alist '(("." . "~/.emacs-saves/"))    ; don't litter my fs tree
;;       delete-old-versions t
;;       kept-new-versions 6
;;       kept-old-versions 2
;;       version-control t)       ; use versioned backups
;; (setq auto-save-file-name-transforms
;;   `((".*" "~/.emacs-saves/" t)))

;;(setq tramp-backup-directory-alist backup-directory-alist)

(remove-hook! '(shell-mode-hook vterm-mode-hook eshell-mode-hook) #'hide-mode-line-mode)
;;(add-hook! (shell-mode vterm-mode eshell-mode dired-mode) (solaire-mode -1))
;;(add-hook! (shell-mode eshell-mode dired-mode) (solaire-mode -1))

;; (use-package! eshell-vterm
;;   :defer-incrementally t
;;   :after eshell
;;   :config
;;   (eshell-vterm-mode)
;;   (defalias 'eshell/v 'eshell-exec-visual)
;;   )

(setq kill-ring-max 500)

;; Create a shell with remote-process info in buffer-name - call interactively to spawn new shells with decent names
(defun +thsc/shell ()
  (interactive)
  (shell (generate-new-buffer-name (format "shell:%s" (concat (file-remote-p default-directory 'user) "@" (file-remote-p default-directory 'host)))))
  )

;; Add new shells to perspective (workspace)
(add-hook! (shell-mode vterm-mode eshell-mode) (persp-add-buffer (current-buffer)))

;; (defun basic-remote-try-completion (string table pred point)
;;   (and (vertico--remote-p string)
;;        (completion-basic-try-completion string table pred point)))

;; (defun basic-remote-all-completions (string table pred point)
;;   (and (vertico--remote-p string)
;;        (completion-basic-all-completions string table pred point)))

;; (add-to-list
;;  'completion-styles-alist
;;  '(basic-remote basic-remote-try-completion basic-remote-all-completions nil))

(setq completion-category-overrides '((file (styles basic-remote orderless))))

(use-package! tramp
  :defer-incrementally t)
;; (use-package! plsql
;;   :defer-incrementally t)
;; (use-package! sqlplus
;;   :defer-incrementally t)


(use-package! vlf-setup
  :defer-incrementally t
  )

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

;; FIXME writegood-mode hook from package overwrite to not start unless prompted
(setq evil-vsplit-window-right t
      evil-split-window-below t)

(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (consult-buffer))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default nil))

;; writegood-mode will be activated when needed, not before
(remove-hook! (org-mode markdown-mode rst-mode asciidoc-mode latex-mode LaTeX-mode) #'writegood-mode)


;; spell-check will be activated when needed, not before
(remove-hook! (org-mode markdown-mode TeX-mode rst-mode mu4e-compose-mode message-mode) #'flyspell-mode)

;;(after! org
;;(server-start)
;;)

  ;; (eval-after-load "tramp"
  ;;   '(progn
  ;;      (add-to-list 'tramp-methods
  ;;                   (mapcar
  ;;                    (lambda (x)
  ;;                      (cond
  ;;                       ((equal x "sshx") "cygssh")
  ;;                       ;; ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "fakecygpty c:\\cygwin64\\bin\\ssh\.exe"))
  ;;                       ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "/usr/bin/ssh"))
  ;;                       (t x)))
  ;;                    (assoc "sshx" tramp-methods)))
  ;;      (setq tramp-default-method "cygssh")))

  ;; (eval-after-load "tramp"
  ;;   '(progn
  ;;      (add-to-list 'tramp-methods
  ;;                   (mapcar
  ;;                    (lambda (x)
  ;;                      (cond
  ;;                       ((equal x "ssh") "cygssh2")
  ;;                       ;; ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "fakecygpty c:\\cygwin64\\bin\\ssh\.exe"))
  ;;                       ((eq (car x) 'tramp-login-program) (list 'tramp-login-program "/usr/bin/ssh"))
  ;;                       (t x)))
  ;;                    (assoc "ssh" tramp-methods)))
  ;;      (setq tramp-default-method "cygssh2")))

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(add-to-list 'load-path "~/doom-vertico-config/snippets")

;; emacs-w32 outcomment
;;(require 'fakecygpty)
;;;(fakecygpty-activate)
;;(setq tramp-encoding-shell "C:/cygwin64/bin/bash.exe")
;; emacs-w32 outcomment

;; Not required when setting W32 Environment variable SHELL (NOT $SHELL) to ...cygwin..bin..bash.exe-path
;; This way, tramp is not weird when opening shells on remote
;;(setq explicit-shell-file-name "C:/cygwin64/bin/bash.exe")

(defun my-shell-mode-hook ()
  ;;(interactive)
  (setq comint-input-ring-file-name
        (if (file-remote-p default-directory)
            (with-parsed-tramp-file-name default-directory nil
              (tramp-make-tramp-file-name
               (tramp-file-name-method v)
               (tramp-file-name-user v)
               (tramp-file-name-domain v)
               (tramp-file-name-host v)
               (tramp-file-name-port v)
               "~/.bash_history"))
          "~/.bash_history"))
  (comint-read-input-ring t))

;; ;; I want an easy command for opening new shells:
;; (defun new-shell (name)
;;   "Opens a new shell buffer with the given name in
;;     asterisks (*name*) in the current directory and changes the
;;     prompt to 'name>'."
;;   (interactive "sName: ")
;;   ;;(pop-to-buffer (concat "*" name "*"))
;;   (pop-to-buffer (generate-new-buffer-name (format "shell name %s" (concat (file-remote-p default-directory 'user) "at" (file-remote-p default-directory 'host)))))
;;   (unless (eq major-mode 'shell-mode)
;;     (shell (current-buffer))
;;   ;;(shell (generate-new-buffer-name (format "shell:%s" (concat (file-remote-p default-directory 'user) "@" (file-remote-p default-directory 'host)))))
;;     (auto-save-mode)
;;     (sleep-for 0 200)
;;     (delete-region (point-min) (point-max))
;;     (comint-simple-send (get-buffer-process (current-buffer))
;;                         (concat "export PS1=\"\033[33m" name "\033[0m:\033[35m\\W\033[0m>\"")))
;;   )
;; I want an easy command for opening new shells: GOOOOD
;; (defun new-shell ()
;;   "Opens a new shell buffer with the given name in
;;     asterisks (*name*) in the current directory and changes the
;;     prompt to 'name>'."
;;   (interactive)
;;   ;;(pop-to-buffer (concat "*" name "*"))
;;   ;;(pop-to-buffer (generate-new-buffer-name (format "shell name %s" (concat (file-remote-p default-directory 'user) "at" (file-remote-p default-directory 'host)))))
;;   (unless (eq major-mode 'shell-mode)
;;     ;;(shell (current-buffer))
;;   (shell (generate-new-buffer-name (format "shell %s" (concat (file-remote-p default-directory 'user) "@" (file-remote-p default-directory 'host)))))
;;     (auto-save-mode)
;;     (sleep-for 0 200)
;;     (delete-region (point-min) (point-max))
;;     (comint-simple-send (get-buffer-process (current-buffer))
;;                         (concat "export PS1=\"\033[33m" "\033[0m:\033[35m\\W\033[0m>\"")))
;;   )

(defun new-shell ()
  "Opens a new shell buffer with the given name in
    asterisks (*name*) in the current directory and changes the
    prompt to 'name>'."
  (interactive)
  ;;(pop-to-buffer (concat "*" name "*"))
  ;;(pop-to-buffer (generate-new-buffer-name (format "shell name %s" (concat (file-remote-p default-directory 'user) "at" (file-remote-p default-directory 'host)))))
  (unless (eq major-mode 'org-mode)
    ;;(shell (current-buffer))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                            (format "%s" (read-from-minibuffer "Name: "))
                                                           )))))
    (auto-save-mode)
    (sleep-for 0 200)
    (delete-region (point-min) (point-max))
    (comint-simple-send (get-buffer-process (current-buffer))
                        (concat "export PS1=\"\033[33m" "\033[0m:\033[35m\\W\033[0m>\"")))
                        ;;(concat "export PS1=\"[\\d \\t \\u@\\h:\\w ] $ \"")))
  )
;;(global-set-key (kbd "C-c s") 'new-shell)
(defun new-sudo-shell-as (user)
  "Opens a new shell buffer with the given name in
    asterisks (*name*) in the current directory and changes the
    prompt to 'name>'."
  (interactive "sUser: ")
  ;;(pop-to-buffer (concat "*" name "*"))
  ;;(pop-to-buffer (generate-new-buffer-name (format "shell name %s" (concat (file-remote-p default-directory 'user) "at" (file-remote-p default-directory 'host)))))
  (unless (eq major-mode 'shell-mode)
    ;;(shell (current-buffer))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                            (format "%s" (read-from-minibuffer "Name: "))
                                                           )))))
    (auto-save-mode)
    (sleep-for 0 200)
    (delete-region (point-min) (point-max))
    (comint-simple-send (get-buffer-process (current-buffer))
                        (concat "export PS1=\"\033[33m" "\033[0m:\033[35m\\W\033[0m>\"")))
                        ;;(concat "export PS1=\"[\\d \\t \\u@\\h:\\w ] $ \"")))
  )

(defun cygwin-shell ()
  "Open a cygwin bash shell. Works best with fakecygpty."
  (interactive)
  (let ((explicit-shell-file-name "C:/cygwin64/bin/bash"))
    (call-interactively 'shell)))

;; (use-package! mixed-pitch
;;   :hook (org-mode . mixed-pitch-mode)
;;   :config
;;   (setq mixed-pitch-set-heigth t
;;         mixed-pitch-variable-pitch-cursor nil)
;;   (set-face-attribute 'variable-pitch nil :height 5.3))



(setq current-iso639-language 'en)
;;
;; System locale to use for formatting time values.
(setq system-time-locale "C")         ; Make sure that the weekdays in the
                                      ; time stamps of your Org mode files and
                                      ; in the agenda appear in English.


(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t%-6e% s")
       (todo . " %i %-12:c")
       (tags . " %i %-12:c")
       (search . " %i %-12:c"))
      )

;; set timeformat as 24H
(setq display-time-24hr-format t)
;; Display clock in emacs
(display-time-mode 1)

  ;; Trying out the latest and greatest GTD
(use-package! org-gtd
  :after org
  :config
  (setq org-gtd-directory "~/org/gtd/")
  (setq org-gtd-default-file-name "actionable")
  (org-edna-mode)
  (setq org-edna-use-inheritance t)
  (map! :leader
        (:prefix ("d" . "org-gtd")
         :desc "Capture"        "c"  #'org-gtd-capture
         :desc "Engage"         "e"  #'org-gtd-engage
         :desc "Process inbox"  "p"  #'org-gtd-process-inbox
         :desc "Show all next"  "n"  #'org-gtd-show-all-next
         :desc "Stuck projects" "s"  #'org-gtd-show-stuck-projects))
  (map! :map org-gtd-process-map
        :desc "Choose" "C-c c" #'org-gtd-choose))

(use-package! olivetti
  :after org
  ;;:hook (olivetti-mode . double-header-line-mode)
  :config
  (setq olivetti-min-body-width 50
        olivetti-body-width 120
        ;;olivetti-style 'fancy ; fantastic new layout
        ;; olivetti-margin-width 12
        )
  ;; (add-hook! 'olivetti-mode-hook (window-divider-mode -1))
  ;; (add-hook! 'olivetti-mode-hook (set-face-attribute 'window-divider nil :foreground (face-background 'fringe) :background (face-background 'fringe)))
  ;; (add-hook! 'olivetti-mode-hook (set-face-attribute 'vertical-border nil :foreground (face-background 'fringe) :background (face-background 'fringe)))
  )

(setq comint-password-prompt-regexp "\\(^ *\\|\\(database\\|Vault\\|SMB\\|'s\\|Bad\\|C\\(?:VS\\|urrent\\)\\|Enter\\(?: \\(?:Auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Re\\(?:peat\\|type\\)\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|enter\\(?: \\(?:auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|login\\|new\\|old\\) +.*\\)\\(?:\\(?:adgangskode\\|contrase\\(?:\\(?:ny\\|ñ\\)a\\)\\|decryption key\\|encryption key\\|geslo\\|h\\(?:\\(?:asł\\|esl\\)o\\)\\|iphasiwedi\\|jelszó\\|l\\(?:ozinka\\|ösenord\\)\\|m\\(?:ot de passe\\|ật khẩu\\)\\|p\\(?:a\\(?:rola\\|s\\(?:ahitza\\|s\\(?: phrase\\|code\\|ord\\|phrase\\|wor[dt]\\)\\|vorto\\)\\)\\|in\\)\\|s\\(?:alasana\\|enha\\|laptažodis\\)\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\)\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'\\|^([^)@
]+@[^)@
]+) Password: *\\'")

(after! shell
  (load! "+shell"))

(setq auth-sources '(password-store "~/.emacs_authinfo.gpg"))
(setq magit-process-find-password-functions '(magit-process-password-auth-source))

(require 'auth-source-pass)
;; (setq auth-sources '(password-store))
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

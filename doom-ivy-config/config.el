;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.

(setq user-full-name "Thomas Schwanberger"
      user-mail-address "thomas@schwanberger.dk")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light)
;;(setq doom-font (font-spec :family "Iosevka" :size 16 :weight 'light)
(setq doom-font (font-spec :family "Iosevka" :size 17)
      ;;(setq doom-font (font-spec :family "Roboto Mono" :size 17 :weight 'light)
      ;;doom-variable-pitch-font (font-spec :family "Overpass" :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Roboto" :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Noto Serif" :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Iosevka Aile")
      doom-variable-pitch-font (font-spec :family "Iosevka Etoile")
      ;;doom-variable-pitch-font (font-spec :family "ETBembo")
      ;;doom-serif-font doom-variable-pitch-font
      doom-big-font (font-spec :family "Noto Serif" :size 30)
      )
;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

(use-package! modus-themes
  :defer t
  :init
  (setq modus-themes-org-blocks 'gray-background
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
        ;;modus-themes-syntax '(faint alt-syntax)
        modus-themes-syntax '(green-strings alt-syntax)
        )
  (modus-themes-load-themes)
  )

(add-hook! 'modus-themes-after-load-theme-hook
  (defun my-modus-themes-custom-faces ()
    (modus-themes-with-colors
      (custom-set-faces
       ;;",class" found by looking into modus-theme source code in .../straight...
       `(org-quote ((,class :slant italic)))
       ;; Only these two needs to be defined for mixed-pitch-mode working in both states
       `(default ((nil (,doom-font))))
       `(fixed-pitch ((nil (,doom-font))))
       )
      )
    )
  )

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
(setq confirm-kill-emacs nil)
(setq select-enable-clipboard t)
(after! org
  (require 'org-indent)
  (setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org"))
  ;; Linebreaks: WYSISYG
  (setq org-export-preserve-breaks t)
  (setq org-pandoc-options-for-docx '(
                                      ;;(reference-doc . "C:/Projects/todo/pandoc/nc_ref.docx")
                                      (reference-doc . "~/org/todo/pandoc/nc_ref.docx")
                                      ))

  (setq org-pandoc-options-for-html5 '(
                                       (number-sections . t)
                                       (toc . t)
                                       (self-contained . t)
                                        ;(template . "C:/Projects/todo/easy_template.html")
                                       ;(template . "C:/Projects/todo/pandoc/html5/github/GitHub.html5")
                                       (template . "~/org/todo/pandoc/html5/github/GitHub.html5")


                                       ;;(template . "C:/Projects/todo/pandoc/html5/kjhealy/html.template")
                                       ))

  ;; (setq org-pandoc-options-for-latex-pdf '(
  ;;                                          (number-sections . t)
  ;;                                          (toc . t)
  ;;                                          (template . "C:/Projects/todo/eisvogel.tex")
  ;;                                          (pdf-engine . "lualatex")
  ;;                                          ))
  (setq org-pandoc-options-for-markdown '(
                                          (toc . t)
                                          ))
  (setq org-pandoc-options-for-gfm '(
                                          (toc . t)
                                          ))
  (require 'org-id)
  (setq org-use-property-inheritance t
        org-log-done 'time ; matches behaviour of orgzly
        org-log-into-drawer t
        org-list-allow-alphabetical t
        org-export-in-background t
        org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
        org-id-link-to-org-use-id 'create-if-interactive
        )
  
  (use-package! org-pandoc-import
    :defer t)
  ;; Don't break evil navigation in org-super-agenda
  (setq org-super-agenda-header-map 'evil-org-agenda-mode-map)
  (setq org-catch-invisible-edits 'smart
        ;;org-export-with-sub-superscripts '{}
        org-export-with-sub-superscripts nil
        org-hide-emphasis-markers t
	org-ellipsis " ▾ "
        )

 
(load! "+org")
)
;; Add icons to modeline
(after! doom-modeline (setq doom-modeline-major-mode-icon t))

(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t)                        ; Nobody likes to loose work, I certainly don't

(setq locale-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(set-keyboard-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(prefer-coding-system 'utf-8-unix)

;; 2013-12-10 IRC #Emacs
(set-clipboard-coding-system 'utf-8-unix)

;; http://www.masteringemacs.org/articles/2012/08/09/working-coding-systems-unicode-emacs/
;; in addition to the lines above:

(set-default-coding-systems 'utf-8-unix)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8-unix)
  (setq default-buffer-file-coding-system 'utf-8-unix))
;; Treat clipboard input as UTF-8-UNIX string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))
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
  :defer t)
(setq comint-input-ring-size 5000)
(defun my-shell-mode-hook ()
  (interactive)
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
(setq plantuml-default-exec-mode 'jar)
(setq org-id-extra-files '(
                           (org-agenda-text-search-extra-files)
                           (directory-files-recursively "/home/thsc/org" "org$")
                           )
      )
(setq password-cache-expiry nil)
(use-package! sqlplus
  :defer t)
(use-package tramp
  :defer t
  :init
  (defvar my-auto-save-folder "~/.emacs-saves/"); folder for auto-saves
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
        tramp-auto-save-directory my-auto-save-folder ; auto-save tramp files in local directory
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
  (add-to-list 'backup-directory-alist
               (cons tramp-file-name-regexp "~/.emacs-saves/"))
  )

(use-package! org-appear
  :defer t
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

;;Autosave-tests
(setq backup-by-copying t      ; don't clobber symlinks
      backup-directory-alist '(("." . "~/.emacs-saves/"))    ; don't litter my fs tree
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t)       ; use versioned backups
(setq auto-save-file-name-transforms
  `((".*" "~/.emacs-saves/" t)))

;;(setq tramp-backup-directory-alist backup-directory-alist)

(remove-hook! '(shell-mode-hook vterm-mode-hook eshell-mode-hook) #'hide-mode-line-mode)
(add-hook! (shell-mode vterm-mode eshell-mode dired-mode) (solaire-mode -1))
(add-hook! (shell-mode vterm-mode eshell-mode) (persp-add-buffer (current-buffer)))

(use-package! eshell-vterm
  :defer t
  :after eshell
  :config
  (eshell-vterm-mode)
  (defalias 'eshell/v 'eshell-exec-visual)
  )

(setq kill-ring-max 5000)

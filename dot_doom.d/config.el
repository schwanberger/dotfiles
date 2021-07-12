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
(setq doom-font (font-spec :family "Iosevka SS14 Extended" :size 16)
;;(setq doom-font (font-spec :family "Iosevka SS14" :size 16)
;;(setq doom-font (font-spec :family "Iosevka SS14" :size 16 :weight 'light)
;;(setq doom-font (font-spec :family "Iosevka Term" :size 15 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
      ;;doom-variable-pitch-font (font-spec :family "Alegreya" :size 15)
      ;;doom-variable-pitch-font (font-spec :family "Cantarell" :size 15 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 15 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :size 16 :weight 'regular)
      ivy-posframe-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light)
      doom-big-font (font-spec :family "Iosevka Etoile" :size 30)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-vibrant)
;;
;; (setq doom-theme 'doom-gruvbox
;;       doom-gruvbox-dark-variant 'hard
;;       )

(setq doom-theme 'doom-one)

;;(setq doom-theme 'doom-solarized-light)
;;(setq doom-theme 'spacemacs-light)
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-nord-light)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 't)


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
;; set-locale to DA_DK
;;(set-locale-environment "DA_DK")
;; Use UTF-8 for all character encoding.
;;(set-language-environment 'utf-8)
;;(set-default-coding-systems 'utf-8)
;;(set-selection-coding-system 'utf-8)
;;(prefer-coding-system 'utf-8)

(setq confirm-kill-emacs nil)
;; WINDOWS SPECIFIC
;;(setq ispell-program-name "C:/tools/msys64/mingw64/bin/aspell.exe")
;; (setq plantuml-jar-path "C:/ProgramData/chocolatey/lib/plantuml/tools/plantuml.jar")
;; (setq org-plantuml-jar-path "C:/ProgramData/chocolatey/lib/plantuml/tools/plantuml.jar")
;; (setq plantuml-default-exec-mode 'jar)
;; (setq grip-binary-path "C:/Python39/Scripts/grip.exe")

;; (setq explicit-shell-file-name "C:/WINDOWS/system32/bash.exe")
;; (setq shell-file-name explicit-shell-file-name)
;; (add-to-list 'exec-path "C:/WINDOWS/system32")
;;(add-to-list 'exec-path "C:/tools/msys64/mingw64/bin")

(setq select-enable-clipboard nil)


(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(add-to-list 'initial-frame-alist '(fullscreen . maximized))

(setq org-pandoc-options-for-docx '(
                                    (reference-doc . "C:/Projects/todo/pandoc/nc_ref.docx")
                                    ))

(setq org-pandoc-options-for-html5 '(
                                     (number-sections . t)
                                      (toc . t)
                                      (self-contained . t)
                                      ;(template . "C:/Projects/todo/easy_template.html")
                                      (template . "C:/Projects/todo/pandoc/html5/github/GitHub.html5")
                                      ;;(template . "C:/Projects/todo/pandoc/html5/kjhealy/html.template")
                                     ))

(setq org-pandoc-options-for-latex-pdf '(
                                         (number-sections . t)
                                         (toc . t)
                                         (template . "C:/Projects/todo/eisvogel.tex")
                                         (pdf-engine . "lualatex")
                                         ))




(after! org
  ;;(setq org-superstar-headline-bullets-list '("■" "◆" "▲" "▶")

  ;; A fix to have #begin_src blocks in another color, it is only a problem in doom-vibrant, and should be fixed in the theme instead
  ;; (require 'color)
  ;; (set-face-attribute 'org-block nil :background
  ;;                     (color-darken-name
  ;;                      (face-attribute 'default :background) 3))


  ;;(setq org-superstar-headline-bullets-list '("■" "◆" "▲")
  ;;(setq org-superstar-headline-bullets-list '("■" "□" "▣" "◆" "◇" "◈")
  ;;(setq org-superstar-headline-bullets-list '("◳" "◰" "◱" "◲" "◈" "◇" "◆" )
  ;;(setq org-superstar-headline-bullets-list '("□" "▣" "■" "◇" "◈" "◆")
  ;;(setq org-superstar-headline-bullets-list '("■" "◆" "▲" "□" "◇" "△")
  ;;(setq org-superstar-headline-bullets-list '("∷" "∴" "∵")
  ;;(setq org-superstar-headline-bullets-list '("∮" "∯" "∰" "∎")
  (setq org-superstar-headline-bullets-list '("☰" "☱" "☲" "☴" "☳" "☶" "☷")

        org-pretty-entities t
        org-hide-emphasis-markers t ;; show actually italicized text instead of /italicized text/
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-superstar-remove-leading-stars t
        ;; For some odd reason, this works on windows but not on linux
        ;; org-superstar-item-bullet-alist '((?* . ?➤)
        ;;                                   (?+ . ?•)
        ;;                                   (?- . ?–))
        org-fontify-quote-and-verse-blocks t)

  (set-face-attribute 'org-document-title nil :font "Iosevka Etoile" :weight 'bold :height 2.0)
  (dolist (face '((org-level-1 . 1.75)
                  (org-level-2 . 1.50)
                  (org-level-3 . 1.25)
                  (org-level-4 . 1.10)
                  (org-level-5 . 1.00)
                  (org-level-6 . 0.90)
                  (org-level-7 . 0.80)
                  (org-level-8 . 0.70)))
    (set-face-attribute (car face) nil :font "Iosevka Etoile" :weight 'bold :height (cdr face)))
  ;; Make sure org-indent face is available
  (require 'org-indent)

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  ;; (set-face-attribute 'org-block nil :foreground nil :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-table nil  :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  ;; (set-face-attribute 'org-code nil   :inherit '(shadow fixed-pitch))
  ;; (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  ;; (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  ;; (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  ;; (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  ;; (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)

  ;; Get rid of the background on column views
  (set-face-attribute 'org-column nil :background nil)
  (set-face-attribute 'org-column-title nil :background nil)
  )

(load! "+org")

(after! org-tree-slide
  (advice-remove 'org-tree-slide--display-tree-with-narrow
                 #'+org-present--hide-first-heading-maybe-a)
  )
(setq +treemacs-git-mode 'deferred)

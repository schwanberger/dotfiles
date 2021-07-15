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
(setq doom-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light)
;;(setq doom-font (font-spec :family "JetBrains Mono Nerd Font" :size 16)
      ;;(setq doom-font (font-spec :family "Iosevka SS14" :size 16)
      ;;(setq doom-font (font-spec :family "Iosevka SS14" :size 16 :weight 'light)
      ;;(setq doom-font (font-spec :family "Iosevka Term" :size 15 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Noto Sans" :size 14)
      ;;doom-variable-pitch-font (font-spec :family "Alegreya" :size 15)
      ;;doom-variable-pitch-font (font-spec :family "Cantarell" :size 15 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Source Sans Pro" :size 15 :weight 'semi-bold)
      doom-variable-pitch-font (font-spec :family "Iosevka Etoile" :size 16 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :size 16 :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Iosevka Aile" :size 16 :weight 'regular)
      ivy-posframe-font (font-spec :family "JetBrains Mono" :size 16 :weight 'light)
      doom-big-font (font-spec :family "Iosevka Etoile" :size 30)
      )

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-dracula)
;;(setq doom-theme 'doom-palenight)
;;(setq doom-theme 'doom-vibrant)
;;(setq doom-theme 'doom-vibrant-darker)
;;(setq doom-theme 'doom-one-light)
(setq doom-theme 'doom-vibrant-dark
      doom-themes-enable-bold t
      doom-themes-enable-italic t
      )

;; (setq doom-theme 'doom-gruvbox
;;       doom-gruvbox-dark-variant 'hard
;;       )

;;(setq doom-theme 'doom-one)

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




(after! org-superstar
  (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
  ;;(setq org-superstar-headline-bullets-list '("■" "◆" "▲")
  ;;(setq org-superstar-headline-bullets-list '("■" "□" "▣" "◆" "◇" "◈")
  ;;(setq org-superstar-headline-bullets-list '("◳" "◰" "◱" "◲" "◈" "◇" "◆" )
  ;;(setq org-superstar-headline-bullets-list '("□" "▣" "■" "◇" "◈" "◆")
  ;;(setq org-superstar-headline-bullets-list '("■" "◆" "▲" "□" "◇" "△")
  ;;(setq org-superstar-headline-bullets-list '("∷" "∴" "∵")
  ;;(setq org-superstar-headline-bullets-list '("∮" "∯" "∰" "∎")
        org-pretty-entities t
        org-hide-emphasis-markers t ;; show actually italicized text instead of /italicized text/
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-superstar-remove-leading-stars t
        ;; For some odd reason, this works on windows but not on linux
        org-superstar-item-bullet-alist '((?- . ?‐)
                                          (?- . ?‐))
        org-fontify-quote-and-verse-blocks t)

  )

(after! org
  (custom-set-faces!
    ;; Make org elements larger
    `(org-document-title :font ,doom-variable-pitch-font :weight bold :height 2.0)
    `(outline-1 :font ,doom-variable-pitch-font :weight bold :height 1.75)
    `(outline-2 :font ,doom-variable-pitch-font :weight bold :height 1.50)
    `(outline-3 :font ,doom-variable-pitch-font :weight bold :height 1.25)
    `(outline-4 :font ,doom-variable-pitch-font :weight bold :height 1.10)
    `(outline-5 :font ,doom-variable-pitch-font :weight bold :height 1.00)
    `(outline-6 :font ,doom-variable-pitch-font :weight bold :height 0.90)
    `(outline-7 :font ,doom-variable-pitch-font :weight bold :height 0.80)
    `(outline-8 :font ,doom-variable-pitch-font :weight bold :height 0.70)
    ;; Get rid of the background on column views
    `(org-column :background nil)
    `(org-column-title :background nil)
    ))

  (require 'org-indent)
(load! "+org")


(after! org-tree-slide
  (advice-remove 'org-tree-slide--display-tree-with-narrow
                 #'+org-present--hide-first-heading-maybe-a)
  )
(setq +treemacs-git-mode 'deferred)

;; From lunik1 config https://github.com/lunik1/.doom.d/blob/master/config.org
(setq +ligatures-in-modes '(org-mode)
      +ligatures-extras-in-modes '(org-mode))

(setq +ligatures-extra-symbols
      '(;; org
        :name          "»"
        :src_block     "›"
        :src_block_end "‹"
        :quote         "“"
        :quote_end     "”"))

(add-hook! 'text-mode-hook #'mixed-pitch-mode)

(after! doom-emacs
  (setq doom-themes-treemacs-theme "doom-colors"))

(setq truncate-string-ellipsis "…")

(after! lsp-mode
  (setq lsp-enable-indentation t
        lsp-enable-on-type-formatting t))

(setq ispell-dictionary "en_GB"
      langtool-default-language "en-GB")

(setq org-use-property-inheritance t
      org-log-done 'time ; matches behaviour of orgzly
      org-list-allow-alphabetical t
      org-export-in-background t
      org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js")

(add-hook! 'org-mode-hook #'+org-pretty-mode)
(setq org-ellipsis " ▾ ")

(use-package! org-appear
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks t)
  ;; for proper first-time setup, `org-appear--set-fragments'
  ;; needs to be run after other hooks have acted.
  (run-at-time nil nil #'org-appear--set-fragments))

(use-package! org-pandoc-import)

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
(setq doom-font (font-spec :family "JetBrains Mono" :size 17 :weight 'light)
      ;;(setq doom-font (font-spec :family "Roboto Mono" :size 17 :weight 'light)
      ;;doom-variable-pitch-font (font-spec :family "Overpass" :weight 'regular)
      ;;doom-variable-pitch-font (font-spec :family "Roboto" :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Noto Serif" :size 17 :weight 'regular)
      ;;doom-serif-font doom-variable-pitch-font
      doom-big-font (font-spec :family "Noto Serif" :size 30)
      )


(use-package! modus-themes
  :init
  (setq modus-themes-org-blocks 'gray-background
        modus-themes-bold-constructs t
        modus-themes-italic-constructs t
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

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-vibrant-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

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

;; Keep Emacs seperate from clipboard
;; To yank/paste to/from clipboard, use register "+"
(setq select-enable-clipboard nil)
(setq select-enable-primary nil)

;; Startup maximised
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

;; Prevents some cases of Emacs flickering - from hlissner config, makes performance worse in my setup
;;(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(after! org
  (require 'org-indent)
  (setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org"))
  (custom-set-faces!
    '(org-document-title :height 1.2)
    '(outline-1 :weight extra-bold :height 1.25)
    '(outline-2 :weight bold :height 1.15)
    '(outline-3 :weight bold :height 1.12)
    '(outline-4 :weight semi-bold :height 1.09)
    '(outline-5 :weight semi-bold :height 1.06)
    '(outline-6 :weight semi-bold :height 1.03)
    '(outline-8 :weight semi-bold)
    '(outline-9 :weight semi-bold)
    ;; Get rid of the background on column views
    '(org-column :background nil)
    '(org-column-title :background nil)
    )
  (after! org-superstar
    (setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●")
          org-superstar-prettify-item-bullets t
          org-hide-emphasis-markers t
          org-superstar-remove-leading-stars t
          ))
  (setq org-fontify-quote-and-verse-blocks t)
  ;; FIXME this will have to be done for WSL
  ;; (setq org-pandoc-options-for-docx '(
  ;;                                     (reference-doc . "C:/Projects/todo/pandoc/nc_ref.docx")
  ;;                                     ))

  ;; (setq org-pandoc-options-for-html5 '(
  ;;                                      (number-sections . t)
  ;;                                      (toc . t)
  ;;                                      (self-contained . t)
  ;;                                       ;(template . "C:/Projects/todo/easy_template.html")
  ;;                                      (template . "C:/Projects/todo/pandoc/html5/github/GitHub.html5")


  ;;                                      ;;(template . "C:/Projects/todo/pandoc/html5/kjhealy/html.template")
  ;;                                      ))

  ;; (setq org-pandoc-options-for-latex-pdf '(
  ;;                                          (number-sections . t)
  ;;                                          (toc . t)
  ;;                                          (template . "C:/Projects/todo/eisvogel.tex")
  ;;                                          (pdf-engine . "lualatex")
  ;;                                          ))
  (require 'org-id)
  (setq org-use-property-inheritance t
        org-log-done 'time ; matches behaviour of orgzly
        org-log-into-drawer t
        org-list-allow-alphabetical t
        org-export-in-background t
        org-re-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
        org-id-link-to-org-use-id 'create-if-interactive
        )

  (add-hook! 'org-mode-hook #'+org-pretty-mode)
  (setq org-ellipsis " ▾ ")

  (use-package! org-appear
    :hook (org-mode . org-appear-mode)
    :config
    (setq org-appear-autoemphasis t
          org-appear-autosubmarkers t
          org-appear-autolinks nil)
    ;; for proper first-time setup, `org-appear--set-fragments'
    ;; needs to be run after other hooks have acted.
    (run-at-time nil nil #'org-appear--set-fragments))

  (use-package! org-pandoc-import)

  (defun +thsc/org-tree-slide-mode-hook ()
    "Line numbering to be disabled. Mixed-pitch-mode to be enabled and then disabled."
    (let ((org-tree-slide-mode-active org-tree-slide-mode))
      (setq display-line-numbers (not org-tree-slide-mode-active))
      (mixed-pitch-mode (if org-tree-slide-mode-active 't 0))
      )
    )

  (add-hook! 'org-tree-slide-mode-hook '+thsc/org-tree-slide-mode-hook)
  )

(load! "+org")

;; This messes with org-tree-slide-mode
;;(defun locally-defer-font-lock ()
;;  "Set jit-lock defer and stealth, when buffer is over a certain size."
;;  (when (> (buffer-size) 50000)
;;    (setq-local jit-lock-defer-time 0.05
;;                jit-lock-stealth-time 1)))
;;
;;(add-hook! 'org-mode-hook #'locally-defer-font-lock)

(setq +treemacs-git-mode 'deferred)

;; From lunik1 config https://github.com/lunik1/.doom.d/blob/master/config.org
;; In general, limit ligatures to only org-mode -- more modes can be added
(setq +ligatures-in-modes '(org-mode)
      +ligatures-extras-in-modes '(org-mode)
      )

 (setq +ligatures-extra-symbols
       '(;; org
         ;;:name          "»"
         :src_block     "»"
         :src_block_end "«"
         :quote         "❝"
         :quote_end     "❞"
         )
       )

(setq truncate-string-ellipsis "…")

(after! lsp-mode
  (setq lsp-enable-indentation t
        lsp-enable-on-type-formatting t))

(setq ispell-dictionary "en_GB"
      langtool-default-language "en-GB")

;; Add icons to modeline
(after! doom-modeline (setq doom-modeline-major-mode-icon t))

(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq undo-limit 80000000                         ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                       ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t)                        ; Nobody likes to loose work, I certainly don't

(setq-default x-stretch-cursor t)

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2
        company-show-quick-access t))

(setq-default history-length 1000)
(setq-default prescient-history-length 1000)

;; From trevoke (org-gtd author) https://github.com/Trevoke/.emacs.d/blob/master/aldric.org
;; Activate UTF-8 mode:
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; 2013-12-10 IRC #Emacs
(set-clipboard-coding-system 'utf-8)

;; http://www.masteringemacs.org/articles/2012/08/09/working-coding-systems-unicode-emacs/
;; in addition to the lines above:

(set-default-coding-systems 'utf-8)
;; backwards compatibility as default-buffer-file-coding-system
;; is deprecated in 23.2.
(if (boundp 'buffer-file-coding-system)
    (setq-default buffer-file-coding-system 'utf-8)
  (setq default-buffer-file-coding-system 'utf-8))
;; Treat clipboard input as UTF-8 string first; compound text next, etc.
(setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING))

;; Dirty hack to rebuild ligature table such that it excludes some ligatures that I don't want
(add-hook! 'org-mode-hook :append
  (defun +thsc/ligature-init-composition-table-h ()
    (setq-local +ligature--composition-table (make-char-table nil))
    (setq-local +ligatures-composition-alist
                '(
                  (?!  . "\\(?:!\\(?:==\\|[!=]\\)\\)")                                      ; (regexp-opt '("!!" "!=" "!=="))
                  (?#  . "\\(?:#\\(?:###?\\|_(\\|[#(:=?[_{]\\)\\)")                         ; (regexp-opt '("##" "###" "####" "#(" "#:" "#=" "#?" "#[" "#_" "#_(" "#{"))
                  (?$  . "\\(?:\\$>>?\\)")                                                  ; (regexp-opt '("$>" "$>>"))
                  (?%  . "\\(?:%%%?\\)")                                                    ; (regexp-opt '("%%" "%%%"))
                  (?&  . "\\(?:&&&?\\)")                                                    ; (regexp-opt '("&&" "&&&"))
                  ;;(?*  . "\\(?:\\*\\(?:\\*[*/]\\|[)*/>]\\)?\\)")                            ; (regexp-opt '("*" "**" "***" "**/" "*/" "*>" "*)"))
                  (?+  . "\\(?:\\+\\(?:\\+\\+\\|[+:>]\\)?\\)")                              ; (regexp-opt '("+" "++" "+++" "+>" "+:"))
                  ;; Removing "--" "---" "-|" from regex (?-)
                  ;;(?-  . "\\(?:-\\(?:-\\(?:->\\|[>-]\\)\\|<[<-]\\|>[>-]\\|[:<>|}~-]\\)\\)") ; (regexp-opt '("--" "---" "-->" "--->" "->-" "-<" "-<-" "-<<" "->" "->>" "-}" "-~" "-:" "-|"))
                  (?-  . "\\(?:-\\(?:-\\(?:-?>\\)\\|<[<-]\\|>[>-]\\|[:<>}~]\\)\\)")         ; (regexp-opt '("-->" "--->" "->-" "-<" "-<-" "-<<" "->" "->>" "-}" "-~" "-:"))
                  (?.  . "\\(?:\\.\\(?:\\.[.<]\\|[.=>-]\\)\\)")                             ; (regexp-opt '(".-" ".." "..." "..<" ".=" ".>"))
                  ;;(?/  . "\\(?:/\\(?:\\*\\*\\|//\\|==\\|[*/=>]\\)\\)")                      ; (regexp-opt '("/*" "/**" "//" "///" "/=" "/==" "/>"))
                  (?:  . "\\(?::\\(?:::\\|[+:<=>]\\)?\\)")                                  ; (regexp-opt '(":" "::" ":::" ":=" ":<" ":=" ":>" ":+"))
                  (?\; . ";;")                                                              ; (regexp-opt '(";;"))
                  (?0  . "0\\(?:\\(x[a-fA-F0-9]\\).?\\)") ; Tries to match the x in 0xDEADBEEF
                  ;; (?x . "x") ; Also tries to match the x in 0xDEADBEEF
                  ;; (regexp-opt '("<!--" "<$" "<$>" "<*" "<*>" "<**>" "<+" "<+>" "<-" "<--" "<---" "<->" "<-->" "<--->" "</" "</>" "<<" "<<-" "<<<" "<<=" "<=" "<=<" "<==" "<=>" "<===>" "<>" "<|" "<|>" "<~" "<~~" "<." "<.>" "<..>"))
                  (?<  . "\\(?:<\\(?:!--\\|\\$>\\|\\*\\(?:\\*?>\\)\\|\\+>\\|-\\(?:-\\(?:->\\|[>-]\\)\\|[>-]\\)\\|\\.\\(?:\\.?>\\)\\|/>\\|<[<=-]\\|=\\(?:==>\\|[<=>]\\)\\||>\\|~~\\|[$*+./<=>|~-]\\)\\)")
                  (?=  . "\\(?:=\\(?:/=\\|:=\\|<<\\|=[=>]\\|>>\\|[=>]\\)\\)")               ; (regexp-opt '("=/=" "=:=" "=<<" "==" "===" "==>" "=>" "=>>"))
                  (?>  . "\\(?:>\\(?:->\\|=>\\|>[=>-]\\|[:=>-]\\)\\)")                      ; (regexp-opt '(">-" ">->" ">:" ">=" ">=>" ">>" ">>-" ">>=" ">>>"))
                  (??  . "\\(?:\\?[.:=?]\\)")                                               ; (regexp-opt '("??" "?." "?:" "?="))
                  (?\[ . "\\(?:\\[\\(?:|]\\|[]|]\\)\\)")                                    ; (regexp-opt '("[]" "[|]" "[|"))
                  (?\\ . "\\(?:\\\\\\\\[\\n]?\\)")                                          ; (regexp-opt '("\\\\" "\\\\\\" "\\\\n"))
                  (?^  . "\\(?:\\^==?\\)")                                                  ; (regexp-opt '("^=" "^=="))
                  ;;(?w  . "\\(?:wwww?\\)")                                                   ; (regexp-opt '("www" "wwww"))
                  (?{  . "\\(?:{\\(?:|\\(?:|}\\|[|}]\\)\\|[|-]\\)\\)")                      ; (regexp-opt '("{-" "{|" "{||" "{|}" "{||}"))
                  ;; Removing "|-" from regex
                  ;;(?|  . "\\(?:|\\(?:->\\|=>\\||=\\|[]=>|}-]\\)\\)")                        ; (regexp-opt '("|=" "|>" "||" "||=" "|->" "|=>" "|]" "|}" "|-"))
                  (?|  . "\\(?:|\\(?:->\\|=>\\||=\\|[]=>|}]\\)\\)")                        ; (regexp-opt '("|=" "|>" "||" "||=" "|->" "|=>" "|]" "|}"))
                  (?_  . "\\(?:_\\(?:|?_\\)\\)")                                            ; (regexp-opt '("_|_" "__"))
                  (?\( . "\\(?:(\\*\\)")                                                    ; (regexp-opt '("(*"))
                  (?~  . "\\(?:~\\(?:~>\\|[=>@~-]\\)\\)"))                                  ; (regexp-opt '("~-" "~=" "~>" "~@" "~~" "~~>"))
                )
    (dolist (char-regexp +ligatures-composition-alist)
      (set-char-table-range
       +ligature--composition-table
       (car char-regexp) `([,(cdr char-regexp) 0 font-shape-gstring])))
    (set-char-table-parent +ligature--composition-table composition-function-table))
  )

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

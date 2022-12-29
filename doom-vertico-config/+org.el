;;; +org.el -*- lexical-binding: t; -*-

(after! org-agenda
  (setq org-agenda-start-on-weekday nil)
  (setq org-agenda-start-day "0d")
  ;; Need to see deadline long in advance in some views
  (setq org-deadline-warning-days 365)
  (setq org-duration-format (quote h:mm))
  (add-to-list 'org-agenda-custom-commands '("g" "Scheduled today and all NEXT items" ((agenda "" ((org-agenda-span 1))) (todo "NEXT"))))
  (add-to-list 'org-agenda-custom-commands '("d" "Scheduled today and all NEXT items" (
                                                                                       (agenda "" ((org-agenda-span 1)
                                                                                                   (org-deadline-warning-days 0)
                                                                                                   (org-scheduled-past-days 10000)
                                                                                                   (TODO "NEXT")))))))

(require 'org-indent)
;;(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org"))
;; Should have agenda view that shows only work related and a view that shows both work and private
;; The "scheduled only view" should show both

(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/private/practical.org" "~/org/gtd/actionable.org_archive" "~/org/gtd/inbox.org" "~/org/gtd/gtd_archive_2022"))
;
;;(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/private/practical.org" "~/org/gtd/actionable.org_archive" "~/org/gtd/inbox.org"))

;; Works reasonably well, but sometimes it just stops working
;;(setq org-agenda-files '(""))
;;(setq org-agenda-file-regexp "^.*\\(\\(?:a\\(?:\\(?:ctionabl\\|rchiv\\)e\\)\\|inbox\\)\\).*[^html][^bak][^md]$")
;; (setq org-agenda-file-regexp "^.*\\(_archive$\|_archive_.*\\)")

;; Make lists (all types) behave like headings in regards to folding
(setq org-cycle-include-plain-lists 'integrate)

;; Linebreaks: WYSISYG
(setq org-export-preserve-breaks t)
;; Disable eval on export by default
;; Re-enabled [2022-02-05 Sat] as I maybe want it enabled?
(setq org-export-use-babel t)
(setq org-pandoc-options-for-docx `(
                                    ;;(reference-doc . "C:/Projects/todo/pandoc/nc_ref.docx")
                                    ;;(reference-doc . "~/org/todo/pandoc/nc_ref.docx")
                                    ;;(reference-doc . "/c/Users/thsc/Desktop/nc_ref2.docx")
                                    ;;(reference-doc . "C:/Users/thsc/Desktop/nc_ref2.docx")
                                    (reference-doc . ,(expand-file-name "~/Desktop/nc_ref2.docx"))
                                    ))

(setq org-pandoc-options-for-html5 `(
                                     (number-sections . t)
                                     (toc . t)
                                     (self-contained . t)
                                     ;;(template . "C:/Projects/todo/easy_template.html")
                                     (template . ,(expand-file-name "~/org/todo/pandoc/html5/github/GitHub.html5"))
                                     ;;(template . "C:/Projects/todo/pandoc/html5/kjhealy/html.template")
                                     ))

(setq asciidoctor-command-options "-a sectnums -a toc=left -a source-highlighter=rouge -a rouge-style=thankful_eyes -a icons=font -a prewrap! -v ")

(defun org-pandoc-export-to-asciidoc-then-asciidoctor (&optional a s v b e)
  "Export to asciidoc."
  (interactive)
  (org-pandoc-export 'asciidoc a s v b e)
  (shell-command (concat "asciidoctor " asciidoctor-command-options
                         (file-name-sans-extension buffer-file-name) ".txt"))
  (message "Exported to HTML")
  )

(defun org-export-to-asciidoc-then-asciidoctor ()
  "Export to asciidoc."
  (interactive)
  (org-asciidoc-export-to-asciidoc)
  (shell-command (concat "asciidoctor " asciidoctor-command-options
                         (file-name-sans-extension buffer-file-name) ".txt"))
  (message "Exported to HTML")
  )

(defun adoc-to-asciidoctor ()
  "Run asciidoctor to generate HTML from adoc file."
  (interactive)
  (shell-command (concat "asciidoctor " asciidoctor-command-options buffer-file-name))
  (message "Exported to HTML")
  )

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
(setq org-clock-persist t)
(org-clock-persistence-insinuate)


(use-package! org-pandoc-import
  :defer-incrementally t)
;; Don't break evil navigation in org-super-agenda
(setq org-super-agenda-header-map 'evil-org-agenda-mode-map)
(setq org-catch-invisible-edits 'smart
      ;;org-export-with-sub-superscripts '{}
      org-export-with-sub-superscripts nil
      org-hide-emphasis-markers t
      org-ellipsis " ▾ "
      )

(setq org-todo-keyword-faces '(
                               ("[-]" . +org-todo-active)
                               ("STRT" . +org-todo-active)
                               ("[?]" . +org-todo-onhold)
                               ("WAIT" . +org-todo-onhold)
                               ("HOLD" . +org-todo-onhold)
                               ("PROJ" . +org-todo-project)
                               ("NO" . +org-todo-cancel)
                               ("KILL" . +org-todo-cancel)
                               ("CNCL" . +org-todo-cancel)
                               )
      )


;; agenda clocktable mode fix - 2022-08-07 (from https://github.com/doomemacs/doomemacs/issues/6491)
;; NOTE: Not necessary, pinning to doom-pin of org-mode from march in packages.el
;; (defun clock-and-stay ()
;;   (interactive)
;;   (let ((this-buffer (current-buffer)))
;;     (org-agenda-clockreport-mode)
;;     (switch-to-buffer this-buffer))
;;   )

;; (define-key! org-agenda-mode-map
;;   "R" #'clock-and-stay)

(after! org-tree-slide
  (advice-remove 'org-tree-slide--display-tree-with-narrow
                 #'+org-present--hide-first-heading-maybe-a)
  )

(setq org-id-extra-files '(
                           (org-agenda-text-search-extra-files)
                           (directory-files-recursively (expand-file-name "~/org") ".org$" t)
                           )
      )

;; Update all org-id (if some are missing)
;; (org-id-update-id-locations (directory-files-recursively (expand-file-name "~/org") ".org$" t))

(use-package! org-appear
  :defer-incrementally t
  :hook (org-mode . org-appear-mode)
  :config
  (setq org-appear-autoemphasis t
        org-appear-autosubmarkers t
        org-appear-autolinks nil))

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default nil))

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

(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t%-6e% s")
       (todo . " %i %-12:c")
       (tags . " %i %-12:c")
       (search . " %i %-12:c"))
      )

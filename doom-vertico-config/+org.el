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
                                                                                                   (org-scheduled-past-days 0)))))))

(require 'org-indent)
;;(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org"))
;; Should have agenda view that shows only work related and a view that shows both work and private
;; The "scheduled only view" should show both
(setq org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/private/practical.org"))
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

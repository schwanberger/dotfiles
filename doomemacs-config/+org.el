;;; +org.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2024 Thomas Schwanberger
;;
;; Author: Thomas Schwanberger <thomas@schwanberger.dk>
;; Maintainer: Thomas Schwanberger <thomas@schwanberger.dk>
;; Created: March 22, 2024
;; Modified: March 22, 2024
;; Version: 0.0.1
;; Keywords: abbrev bib c calendar comm convenience data docs emulations extensions faces files frames games hardware help hypermedia i18n internal languages lisp local maint mail matching mouse multimedia news outlines processes terminals tex tools unix vc wp
;; Homepage: https://github.com/thsc/+org
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(use-package! org-gtd
  :after org
  :init
  (setq org-gtd-update-ack "3.0.0")
  :config
  (setq org-gtd-directory "~/org/gtd/"
        org-gtd-default-file-name "actionable"
        org-edna-use-inheritance t)
  (org-edna-mode)
  (map! :leader
        (:prefix ("d" . "org-gtd")
         :desc "Capture"        "c"  #'org-gtd-capture
         :desc "Engage"         "e"  #'org-gtd-engage
         :desc "Process inbox"  "p"  #'org-gtd-process-inbox
         :desc "Show all next"  "n"  #'org-gtd-show-all-next
         :desc "Stuck projects" "s"  #'org-gtd-review-stuck-projects))
  (map! :map org-gtd-clarify-map
        :desc "Organize this item" "C-c c" #'org-gtd-organize))

(after! org-agenda
  (setq org-agenda-start-on-weekday nil
        org-agenda-dim-blocked-tasks nil
        org-agenda-start-day "0d"
        ;; Need to see deadline long in advance in some views
        org-deadline-warning-days 365
        org-duration-format (quote h:mm))
        org-agenda-clockreport-parameter-plist '(:link nil :maxlevel 2) ; 2023-02-27: Fix links everywhere, seen on issue on doom emacs
  (add-to-list 'org-agenda-custom-commands '("g" "Scheduled today and all NEXT items" ((agenda "" ((org-agenda-span 1))) (todo "NEXT"))))
  ;; (add-to-list 'org-agenda-custom-commands '("d" "Scheduled today and all NEXT items" (
  ;;                                                                                      (agenda "" ((org-agenda-span 1)
  ;;                                                                                                  (org-deadline-warning-days 0)
  ;;                                                                                                  (org-scheduled-past-days 10000)
  ;;                                                                                                  (TODO "NEXT")))))))
  (add-to-list 'org-agenda-custom-commands '("d" "Items scheduled up to today" (
                                                                                       (agenda "" ((org-agenda-span 1)
                                                                                                   (org-deadline-warning-days 0)
                                                                                                   (org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/private/practical.org" "~/org/gtd/inbox.org" "~/org/private/nerd.org"))
                                                                                                   (org-scheduled-past-days 10000)
                                                                                                   (TODO "NEXT"))))))

  (add-to-list 'org-agenda-custom-commands '("w" "Items scheduled up to today for NC work" (
                                                                                       (agenda "" ((org-agenda-span 1)
                                                                                                   (org-deadline-warning-days 0)
                                                                                                   (org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/gtd/inbox.org"))
                                                                                                   (org-scheduled-past-days 10000)
                                                                                                   (TODO "NEXT"))))))

  (add-to-list 'org-agenda-custom-commands '("W" "Items scheduled today only for NC work" (
                                                                                       (agenda "" ((org-agenda-span 1)
                                                                                                   (org-deadline-warning-days 0)
                                                                                                   (org-agenda-files '("~/org/gtd/actionable.org" "~/org/todo/new_todo.org" "~/org/gtd/inbox.org"))
                                                                                                   (org-scheduled-past-days 0)
                                                                                                   (TODO "NEXT")))))))

(provide '+org)
;;; +org.el ends here

;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
(package! groovy-mode)
(package! puppet-mode)

;;(package! sqlplus)
;;(package! plsql)
(package! modus-themes)
(package! ef-themes)
(package! org-super-agenda)
(package! org-gtd)
;;(package! shell-pop)
(package! puppet-mode)
(package! ox-gfm)
(package! ox-pandoc)
;;(package! org :built-in 'prefer)
;;(package! counsel-tramp)
;; (package! org-pandoc-import
;;   :recipe (:host github
;;            :repo "tecosaur/org-pandoc-import"
;;            :files ("*.el" "filters" "preprocessors")))
;;(package! org-appear :recipe (:host github :repo "awth13/org-appear"))
;;(unpin! (:term eshell shell term vterm))

;; (package! vterm
;; 	  :recipe (:host github :repo "akermu/emacs-libvterm") :pin "9e5a208d8871293a23a2734591fac97a584a41c2")

(package! xterm-color)
;;(package! eshell-vterm :recipe (:host github :repo "iostapyshyn/eshell-vterm"))
;;(package! selectrum)
;;(package! real-auto-save)

;; Disabled 2023-08-21: Emacs 29 has way better very-large-file support
;;(package! vlf :recipe (:host github :repo "m00natic/vlfi"))
(package! org-auto-tangle)

;;(package! powershell)

;;(package! nano-emacs :recipe (:host github :repo "rougier/nano-emacs"))

;;(package! doom-themes :disable t)
;;(package! doom :disable t)

;;(package! grip-mode)

(package! pandoc-mode)
(package! olivetti)
(package! org-edna)

;;(package! gradle-mode :recipe (:host github :repo "jacobono/emacs-gradle-mode"))
;; Not working as intended on windows

(package! ox-asciidoc)
;;(package! adoc-mode)

;; agenda clocktable mode fix - 2022-08-07 (from https://github.com/doomemacs/doomemacs/issues/6491)
;;(package! org-mode :pin "971eb6885ec996c923e955730df3bafbdc244e54")
;; Newer commit that should fix it upstream, but does not allow doom sync
;;(package! org-mode :pin "d3a9c424ba32382fff1da4f4ecb447dc99205261")

;; 2023-07-16: Test to see if unpinning is nice
;; > It isn't, link navigation is bonkers. Keep the DOOM pin for now.
;;(unpin! (:lang org))

(package! ob-sql-mode)

(package! clean-kill-ring :recipe (:host github :repo "NicholasBHubbard/clean-kill-ring.el"))

(package! lambda-themes :recipe (:host github :repo "lambda-emacs/lambda-themes"))

(package! standard-themes :recipe (:host github :repo "protesilaos/standard-themes"))


 ;; (package! org
 ;;   :recipe (:host github
 ;;            :repo "emacs-straight/org-mode"
 ;;            :files (:defaults "etc")
 ;;            :depth 1
 ;;            :build t
 ;;            :pre-build
 ;;            (with-temp-file "org-version.el"
 ;;              (let ((version
 ;;                     (with-temp-buffer
 ;;                       (insert-file-contents (doom-path "lisp/org.el") nil 0 1024)
 ;;                       (if (re-search-forward "^;; Version: \\([^\n-]+\\)" nil t)
 ;;                           (match-string-no-properties 1)
 ;;                         "Unknown"))))
 ;;                (insert (format "(defun org-release () %S)\n" version)
 ;;                        (format "(defun org-git-version (&rest _) \"%s-??-%s\")\n"
 ;;                                version (cdr (doom-call-process "git" "rev-parse" "--short" "HEAD")))
 ;;                        "(provide 'org-version)\n"))))
 ;;   :pin "971eb6885ec996c923e955730df3bafbdc244e54")
 ;;   ;;:pin "d3a9c424ba32382fff1da4f4ecb447dc99205261")

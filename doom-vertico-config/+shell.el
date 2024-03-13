;;; +shell.el -*- lexical-binding: t; -*-

;; Does not work on w32 cygwin does not have sudo
(defun thsc--sudo--as-user-file-path (file user)
  (let ((host (or (file-remote-p file 'host) "::1")))
    (concat "/" (when (file-remote-p file)
                  (concat (file-remote-p file 'method) ":"
                          (if-let (user (file-remote-p file 'user))
                              (concat user "@" host)
                            host)
                          "|"))
            "sudo:root@" "|" "su:" user "@" host
            ":" (or (file-remote-p file 'localname)
                    file))))

(defun +thsc/shell-as-user (user)
  "Open shell in default_directory as user (via sudo)"
  (interactive "s(sudo) shell as user: ")
  (if (file-remote-p default-directory)
    (if (string-match "su:\\w+@" default-directory)
        (+thsc/shell)
  (let
      ((default-directory (thsc--sudo--as-user-file-path default-directory user)))
    (+thsc/shell)))
  (+thsc/shell))
  )
(global-set-key (kbd "C-c s") '+thsc/shell-as-user)

(defun +thsc/shell ()
  (interactive)

  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n $ '")
  )

(defun +thsc/bash ()
  "Opens a bash shell buffer with the given name. If it's a remote
     shell, a unique name will be created for it."
  (interactive)

  (let ((shell-file-name (locate-file "bash" exec-path)))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
  ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ))

(defun +thsc/simple-bash ()
  "Opens a bash shell buffer with the given name. If it's a remote
     shell, a unique name will be created for it."
  (interactive)

  (let ((shell-file-name (locate-file "bash" exec-path)))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
  ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ))

(defun +thsc/simple-zsh ()
  "Opens a bash shell buffer with the given name. If it's a remote
     shell, a unique name will be created for it."
  (interactive)

  (let ((shell-file-name (locate-file "zsh" exec-path)))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
  ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;; (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ))

(defun +thsc/new-shell ()
  "Opens a new shell buffer with the given name in
    asterisks (*name*) in the current directory and changes the
    prompt to 'name>'."
  (interactive)
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  )

(after! tramp
  (defun tramp-remote-eshell (&optional arg)
    "Prompt for a remote host to connect to, and open an eshell
there."
    (interactive "p")
    (let*
        ((hosts
          (cl-reduce 'append
                     (mapcar
                      (lambda (x)
                        (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                      '((tramp-parse-sconfig "/home/vagrant/.ssh/config")))))
         (remote-host (completing-read "Remote host: " hosts)))
      (with-temp-buffer
        (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":"))
        (eshell default-directory))))

  (defun tramp-remote-sqlplus (&optional arg)
    "Prompt for a remote host to connect to, and open sql-oracle
there."
    (interactive "p")
    (let*
        ((hosts
          (cl-reduce 'append
                     (mapcar
                      (lambda (x)
                        (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                      '((tramp-parse-sconfig "/home/vagrant/.ssh/config")))))
         (remote-host (completing-read "SQLPlus at remote host: " hosts)))
      (with-temp-buffer
        (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":"))
        (eshell-command (concat "sudo su - oracle; (sql-oracle \"" (generate-new-buffer-name (format "%s\"\)" remote-host)))))))

  (setq auth-sources '("~/.emacs_authinfo.gpg"))


  (defun thsc/oracle-file-path (file)
    (let ((host (or (file-remote-p file 'host) "localhost")))
      (concat "/" (when (file-remote-p file)
                    (concat (file-remote-p file 'method) ":"
                            (if-let (user (file-remote-p file 'user))
                                (concat user "@" host)
                              host)
                            "|"))
              "sudo:root@" "|" "su:oracle@" host
              ":" (or (file-remote-p file 'localname)
                      file))))

  (defun thsc/grid-file-path (file)
    (let ((host (or (file-remote-p file 'host) "localhost")))
      (concat "/" (when (file-remote-p file)
                    (concat (file-remote-p file 'method) ":"
                            (if-let (user (file-remote-p file 'user))
                                (concat user "@" host)
                              host)
                            "|"))
              "sudo:root@" "|" "su:grid@" host
              ":" (or (file-remote-p file 'localname)
                      file))))

  (defun thsc/oracle-this-file ()
    "Open the current file as oracle."
    (interactive)
    (find-file
     (thsc/oracle-file-path
      (or buffer-file-name
          (when (or (derived-mode-p 'dired-mode)
                    (derived-mode-p 'wdired-mode)
                    (derived-mode-p 'eshell-mode))
            default-directory)))))

  (defun tramp-remote-dired (&optional arg)
    "Prompt for a remote host to connect to, and open an eshell
there."
    (interactive "p")
    (let*
        ((hosts
          (cl-reduce 'append
                     (mapcar
                      (lambda (x)
                        (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                      '((tramp-parse-sconfig "~/.ssh/config")))))
         (remote-host (completing-read "Remote host: " hosts)))
      (with-temp-buffer
        (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host ":/home"))
        (dired default-directory))))

  (defun tramp-remote-dired-scp (&optional arg)
    "Prompt for a remote host to connect to, and open a dired buffer there."
    (interactive "p")
    (let*
        ((hosts
          (cl-reduce 'append
                     (mapcar
                      (lambda (x)
                        (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                      '((tramp-parse-sconfig "~/.ssh/config")))))
         (remote-host (completing-read "Remote host: " hosts)))
      (with-temp-buffer
        (cd (concat "/scp" ":" remote-host ":/home"))
        (dired default-directory))))

  (defun thsc/oracle-shell-this ()
    "Open shell as user oracle in this directory."
    (interactive)
    (if (string-match "su:oracle@" default-directory)
        ;; (+thsc/shell)
        (+thsc/bash)
      (let
          ((default-directory (thsc/oracle-file-path default-directory)))
        ;; (+thsc/shell))))
        (+thsc/bash)))
    (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n(\$ORACLE_SID) $ '")
    )

  (defun thsc/grid-shell-this ()
    "Open shell as user grid in this directory."
    (interactive)
    (if (string-match "su:grid@" default-directory)
        (+thsc/bash)
      (let
          ((default-directory (thsc/grid-file-path default-directory)))
        (+thsc/bash)))
        (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n(\$ORACLE_SID) $ '"))

  (defun tramp-remote-oracle-shell (&optional arg)
    "Prompt for a remote host to connect to, and open an shell for user oracle
there. Autosaving enabled"
    (interactive "p")
    (let*
        ((hosts
          (cl-reduce 'append
                     (mapcar
                      (lambda (x)
                        (cl-remove nil (mapcar 'cadr (apply (car x) (cdr x)))))
                      '((tramp-parse-sconfig "/home/vagrant/.ssh/config")))))
         (remote-host (completing-read "Remote host: " hosts)))
      (with-temp-buffer
        (cd (concat "/" (or tramp-default-method "ssh") ":" remote-host "|" "sudo:root@" "|" "su:oracle@" remote-host ":"))
        (+thsc/shell)
        (auto-save-mode))))
  )

(after! shell
  (require 'xterm-color)
  (setq comint-output-filter-functions
        (remove 'ansi-color-process-output comint-output-filter-functions))

  (add-hook 'shell-mode-hook
            (lambda ()
              ;; Disable font-locking in this buffer to improve performance
              ;; (font-lock-mode -1)
              ;; ;; Prevent font-locking from being re-enabled in this buffer
              ;; (make-local-variable 'font-lock-function)
              ;; (setq font-lock-function (lambda (_) nil))
              (add-hook 'comint-preoutput-filter-functions 'xterm-color-filter nil t)))
  (add-hook! (shell-mode vterm-mode eshell-mode dired-mode term-mode) (solaire-mode -1))
  (remove-hook! '(shell-mode-hook vterm-mode-hook eshell-mode-hook) #'hide-mode-line-mode)
  )

(use-package! vterm
  :defer-incrementally t
  :init
  :config
  (setq vterm-max-scrollback 100000
        vterm-use-vterm-prompt nil
        vterm-timer-delay 0.01)
        vterm-kill-buffer-on-exit nil
  ; I wanna use M-1 to M-n to change quickly between workspaces
  (define-key vterm-mode-map (kbd "M-1") nil)
  (define-key vterm-mode-map (kbd "M-2") nil)
  )

(defun +thsc/vterm ()
  "Create vterm shell. If on remote server, give the buffer a relevant name and
use bash as default shell."
  (require 'vterm)
  (interactive)
  (if
      (file-remote-p default-directory)
      (let ((vterm-shell "/bin/bash"))
        (vterm (generate-new-buffer-name (format "vterm %s" (concat (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time)))))))))
    (vterm (generate-new-buffer-name (format "vterm %s" (concat (format "%s" (read-from-minibuffer "Name: ")))))))
  (auto-save-mode))

(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;; Add new shells to perspective (workspace)
(add-hook! (shell-mode vterm-mode eshell-mode) (persp-add-buffer (current-buffer)))

;; Create a shell with remote-process info in buffer-name - call interactively to spawn new shells with decent names
;; (defun +thsc/shell ()
;;   (interactive)
;;   (shell (generate-new-buffer-name (format "shell:%s" (concat (file-remote-p default-directory 'user) "@" (file-remote-p default-directory 'host)))))
;;   )

(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

(defun cygwin-shell ()
  "Open a cygwin bash shell. Works best with fakecygpty."
  (interactive)
  (let ((explicit-shell-file-name "C:/cygwin64/bin/bash"))
    (call-interactively 'shell)))

(setq comint-password-prompt-regexp "\\(^ *\\|\\(database\\|Vault\\|SMB\\|'s\\|Bad\\|C\\(?:VS\\|urrent\\)\\|Enter\\(?: \\(?:Auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|Kerberos\\|LDAP\\|New\\|Old\\|PEM\\|Re\\(?:peat\\|type\\)\\|SUDO\\|UNIX\\|Verify\\|\\[sudo]\\|doas\\|enter\\(?: \\(?:auth\\|\\(?:sam\\|th\\)e\\)\\)?\\|login\\|new\\|old\\) +.*\\)\\(?:\\(?:adgangskode\\|contrase\\(?:\\(?:ny\\|ñ\\)a\\)\\|decryption key\\|encryption key\\|geslo\\|h\\(?:\\(?:asł\\|esl\\)o\\)\\|iphasiwedi\\|jelszó\\|l\\(?:ozinka\\|ösenord\\)\\|m\\(?:ot de passe\\|ật khẩu\\)\\|p\\(?:a\\(?:rola\\|s\\(?:ahitza\\|s\\(?: phrase\\|code\\|ord\\|phrase\\|wor[dt]\\)\\|vorto\\)\\)\\|in\\)\\|s\\(?:alasana\\|enha\\|laptažodis\\)\\|wachtwoord\\|лозинка\\|пароль\\|ססמה\\|كلمة السر\\|गुप्तशब्द\\|शब्दकूट\\|গুপ্তশব্দ\\|পাসওয়ার্ড\\|ਪਾਸਵਰਡ\\|પાસવર્ડ\\|ପ୍ରବେଶ ସଙ୍କେତ\\|கடவுச்சொல்\\|సంకేతపదము\\|ಗುಪ್ತಪದ\\|അടയാളവാക്ക്\\|රහස්පදය\\|ពាក្យសម្ងាត់\\|パスワード\\|密[码碼]\\|암호\\)\\|Response\\)\\(?:\\(?:, try\\)? *again\\| (empty for no passphrase)\\| (again)\\)?\\(?: [[:alpha:]]+ .+\\)?[[:blank:]]*[:：៖][[:space:]]*\\'\\|^Enter encryption key: (repeat) *\\'\\|^([^)@
]+@[^)@
]+) Password: *\\'")

(defun dfeich/ansi-terminal (&optional path name)
  "Opens an ansi terminal at PATH. If no PATH is given, it uses
the value of `default-directory'. PATH may be a tramp remote path.
The ansi-term buffer is named based on `name' "
  (interactive)
  (unless path (setq path default-directory))
  (unless name (setq name "ansi-term"))
  (ansi-term "/bin/bash" name)
  (let ((path (replace-regexp-in-string "^file:" "" path))
        (cd-str
         "fn=%s; if test ! -d $fn; then fn=$(dirname $fn); fi; cd $fn;")
        (bufname (concat "*" name "*" )))
    (if (tramp-tramp-file-p path)
        (let ((tstruct (tramp-dissect-file-name path)))
          (cond
           ((equal (tramp-file-name-method tstruct) "ssh")
            (process-send-string bufname (format
                                          (concat  "ssh -t %s '"
                                                   cd-str
                                                   "exec bash'; exec bash; clear\n")
                                          (tramp-file-name-host tstruct)
                                          (tramp-file-name-localname tstruct))))
           (t (error "not implemented for method %s"
                     (tramp-file-name-method tstruct)))))
      (process-send-string bufname (format (concat cd-str " exec bash;clear\n")
                                           path)))))

(defun nadvice/term-exec-1 (name buffer command switches)
  (let* ((environment
          (list
           (format "TERM=%s" term-term-name)
           (format "TERMINFO=%s" data-directory)
           (format term-termcap-format "TERMCAP="
                   term-term-name term-height term-width)
           (format "EMACS=%s (term:%s)" emacs-version term-protocol-version)
           (format "INSIDE_EMACS=%s,term:%s" emacs-version term-protocol-version)
           (format "LINES=%d" term-height)
           (format "COLUMNS=%d" term-width)))
         (process-environment
          (append environment
                  process-environment))
         (tramp-remote-process-environment
          (append environment
                  tramp-remote-process-environment))
         (process-connection-type t)
         (coding-system-for-read 'binary))
    (apply 'start-file-process name buffer
       "/bin/sh" "-c"
       (format "stty -nl echo rows %d columns %d sane 2>/dev/null;\
if [ $1 = .. ]; then shift; fi; exec \"$@\""
           term-height term-width)
       ".."
       command switches)))

(advice-add 'term-exec-1 :override #'nadvice/term-exec-1)

(map! :after vterm
 :map vterm-mode-map
 "C-c C-p" #'+thsc/paste-from-minibuffer-vterm)

(map! :after shell
      :map shell-mode-map
      :leader
      (:prefix-map ("s" . "search")
       :desc "Search history (via consult-history) useful in shell-mode." "h" #'consult-history))

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
  ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
  ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  (comint-simple-send (current-buffer) "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  )

(defun +thsc/new-shell ()
  "Opens a new shell buffer with the given name in
    asterisks (*name*) in the current directory and changes the
    prompt to 'name>'."
  (interactive)
  ;;(pop-to-buffer (concat "*" name "*"))
  ;;(pop-to-buffer (generate-new-buffer-name (format "shell name %s" (concat (file-remote-p default-directory 'user) "at" (file-remote-p default-directory 'host)))))
  ;;(shell (current-buffer))
  (shell (generate-new-buffer-name (format "shell %s" (concat
                                                       (if (file-remote-p default-directory)
                                                           (concat (file-remote-p default-directory 'user) "_" (file-remote-p default-directory 'host) "___" (sha1 (format "%s" (current-time))))
                                                         (format "%s" (read-from-minibuffer "Name: "))
                                                         )))))
  (auto-save-mode)
  ;;(comint-send-string (current-buffer) "PS1=\"\\u@\\h:\\W$ \""))
  ;;(comint-send-string (current-buffer) "PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '")
  ;;(comint-redirect-send-command "export PS1='[\\u@\\h \\W] \\D{%F %T}\n$ '" (current-buffer) "Wow")
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

  (defun thsc/oracle-shell-this ()
    "Open shell as user oracle in this directory."
    (interactive)
    (if (string-match "su:oracle@" default-directory)
        (+thsc/shell)
      (let
          ((default-directory (thsc/oracle-file-path default-directory)))
        (+thsc/shell))))

  (defun thsc/grid-shell-this ()
    "Open shell as user grid in this directory."
    (interactive)
    (if (string-match "su:grid@" default-directory)
        (+thsc/shell)
      (let
          ((default-directory (thsc/grid-file-path default-directory)))
        (+thsc/shell))))

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

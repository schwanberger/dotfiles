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
  (let
      ((default-directory (thsc--sudo--as-user-file-path default-directory user)))
    (+thsc/shell))
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

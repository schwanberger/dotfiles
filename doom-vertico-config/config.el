;;; ~/doom-vertico-config/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Thomas Schwanberger"
      user-mail-address "thomas@schwanberger.dk")

(setq doom-font (font-spec :family "SFMono Nerd Font" :size 16 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Overpass Nerd Font"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)

(setq doom-theme 'doom-vibrant
      doom-themes-treemacs-theme 'doom-colors
      doom-acario-dark-brighter-modeline t
      doom-acario-light-brighter-modeline t
      doom-nohl-light-brighter-comments t
      doom-nohl-dark-brighter-comments t)
(after! doom-modeline (setq doom-modeline-major-mode-icon t))

(load! "+autosave")             ; Autosave settings
(load! "+defaults")             ; Improved default settings
(after! org (load! "+org"))     ; org-mode settings
(load! "+tramp")                ; Tramp setup
(after! shell (load! "+shell")) ; Shell tweaks

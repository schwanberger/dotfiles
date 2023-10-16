;;; ~/doom-vertico-config/config.el -*- lexical-binding: t; -*-

(setq user-full-name "Thomas Schwanberger"
      user-mail-address "thomas@schwanberger.dk")

;; (setq doom-font (font-spec :family "SFMono Nerd Font" :size 16 :weight 'normal)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))

;; (setq doom-font (font-spec :family "JetBrainsMono NF" :size 15 :weight 'semi-bold)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))

;; (setq doom-font (font-spec :family "VictorMono NF" :size 16 :weight 'regular)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))
; (setq doom-font (font-spec :family "VictorMono NF" :size 16)
;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))

;; (setq doom-font (font-spec :family "Iosevka Comfy" :size 16 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))

;; (setq doom-font (font-spec :family "Iosevka Comfy" :size 13.5 :weight 'light)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))

;;(setq doom-font (font-spec :family "MesloLGS NFM" :size 15 :weight 'light))
;; (setq doom-font (font-spec :family "MesloLGSDZ NF" :size 15 :weight 'light)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))
;; (setq doom-font (font-spec :family "JetBrainsMono NFM" :size 11.0 :weight 'light)
;;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))
; (setq doom-font (font-spec :family "GoMono NFM" :size 11.0 :weight 'light)
;       doom-variable-pitch-font (font-spec :family "Overpass Nerd Font" :weight 'light))
;
;; (setq doom-font (font-spec :family "VictorMono NFM" :size 12.5 :weight 'normal))
;;(setq doom-font (font-spec :family "JetBrainsMono NFM" :size 15 :weight 'regular))
(setq doom-font (font-spec :family "Hack Nerd Font" :size 16 :weight 'semi-light))
;; (setq doom-font (font-spec :family "JetBrainsMono NFM" :size 11.0 :weight 'semilight))
;;(setq doom-font (font-spec :family "MesloLGS NFM" :height 26 :weight 'normal))
;;(setq doom-font (font-spec :family "MesloLGS NFM" :size 11.0 :weight 'normal))
;;(setq doom-font (font-spec :family "MesloLGS NFM" :size 13.0 :weight 'normal))
;;(setq doom-font (font-spec :family "JetBrainsMono NF" :size 11.0 :weight 'light))
;; (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 16 :weight 'light))
;;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 11.0 :weight 'light))
;;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font" :size 16 :weight 'semi-light))
;;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Propo" :size 16 :weight 'semi-light))
;;;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Mono" :size 17 :weight 'semi-light))
;; (setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Mono" :size 18 :weight 'semi-light))
;;(setq doom-font (font-spec :family "CaskaydiaCove Nerd Font Mono" :size 16 :weight 'semi-light))
;;(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 13.0 :weight 'regular))
;;(setq doom-font (font-spec :family "IosevkaTerm Nerd Font Mono" :size 17 :weight 'regular))
 ;;(setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 14.0 :weight 'regular))
;; (setq doom-font (font-spec :family "Iosevka Nerd Font Mono" :size 17 :weight 'regular))
;;(setq doom-font (font-spec :family "VictorMono Nerd Font" :size 18 :weight 'semi-bold))
;;(setq doom-font (font-spec :family "CaskaydiaCove NF Mono" :size 18 :weight 'semi-light))
;;(setq doom-font (font-spec :family "VictorMono Nerd Font" :size 19 :weight 'semi-bold))
;;(setq doom-font (font-spec :family "FiraMono Nerd Font Mono" :size 19 :weight 'regular))
;;(setq doom-font (font-spec :family "MesloLGS Nerd Font" :size 14.0 :weight 'light))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'visual)


;;(setq doom-theme 'modus-vivendi-tinted
(setq doom-theme 'doom-vibrant
      doom-themes-treemacs-theme 'doom-colors
      doom-acario-dark-brighter-modeline t
      doom-acario-light-brighter-modeline t
      doom-nohl-light-brighter-comments t
      doom-nohl-dark-brighter-comments t)

;; (after! solaire-mode
;;   (add-to-list 'solaire-mode-themes-to-face-swap 'doom-one))

(after! doom-modeline (setq doom-modeline-major-mode-icon t))

(load! "+autosave")             ; Autosave settings
(load! "+defaults")             ; Improved default settings
(after! org (load! "+org"))     ; org-mode settings
(load! "+tramp")                ; Tramp setup
(after! shell (load! "+shell")) ; Shell tweaks

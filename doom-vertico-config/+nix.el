;;; +nix.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2023 Thomas Schwanberger
;;
;; Author: Thomas Schwanberger <thomas@schwanberger.dk>
;; Maintainer: Thomas Schwanberger <thomas@schwanberger.dk>
;; Created: November 28, 2023
;; Modified: November 28, 2023
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/thsc/+nix
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:



(defun +thsc/nixos-rebuild-switch()
  "Run 'sudo nixos-rebuild switch --flake ~/nix'."
  (interactive)
  (async-shell-command "sudo nixos-rebuild switch --flake ~/nix")
  )
;;; +nix.el ends here

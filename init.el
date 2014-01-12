(message "* --[ Loading Emacs init.el ]--")
(setq emacs-load-start-time (current-time))

;; Some initial default mode settings
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; No splash screen
(setq inhibit-startup-message t)

;; turn on Common Lisp support
(require 'cl)

;; Set up load path
(add-to-list 'load-path user-emacs-directory)
(require 'load-path)

;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file)

;; Load environment specific macros
(require 'environment)

;; Set up appearance early
(require 'appearance)

;; init.el --- Emacs configuration

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/") t)

;; load neotree - clone it first then provide it's path
;; use command+F8 to toggle
(add-to-list 'load-path "/Users/ekisa/.emacs.d/elpa/neotree")
(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

(package-initialize)
(print "installing..")
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(;; google's material theme
    material-theme
    
    ;; git integration
    magit
    
    ;; a collection of minor changes to the Emacs defaults that makes a great
    ;; base to begin customizing from
    better-defaults
    
    ;; python integration
    elpy
    
    ;; python linting
    flycheck
    py-autopep8
    
    ;; clojure project navigation
    projectile
    
    ;; makes handling lisp expressions much, much easier
    ;; Cheatsheet: http://www.emacswiki.org/emacs/PareditCheatsheet
    paredit
    
    ;; key bindings and code colorization for Clojure
    ;; https://github.com/clojure-emacs/clojure-mode
    clojure-mode
    
    ;; extra syntax highlighting for clojure
    clojure-mode-extra-font-locking
    
    ;; integration with a Clojure REPL
    ;; https://github.com/clojure-emacs/cider
    ;; CIDER - Clojure Interactive Development Environment that Rocks for Emacs
    cider

    ;; useful for osx users
    exec-path-from-shell
    ))

;; ensure env var inside Emacs look the same as in the user's shell - osx
(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

;; install packages
(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; add packages installed by Homebrew added to load-path
(let ((default-directory "/usr/local/share/emacs/site-lisp/"))
  (normal-top-level-add-subdirs-to-load-path))


;; BASIC CUSTOMIZATION
;; --------------------------------------


(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'material t) ;; load material theme
(global-linum-mode t) ;; enable line numbers globally

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)
;; (elpy-use-ipython)

;; alias for pyvenv-workon
(defalias 'workon 'pyvenv-workon)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; enable autopep8 formatting on save
(require 'py-autopep8)
(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; fullscreen
(custom-set-variables
 '(initial-frame-alist (quote ((fullscreen . maximized)))))


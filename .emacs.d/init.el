(require 'package)

(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)

(when (< emacs-major-version 24)
  ; For compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-list
      '(
        evil
        evil-leader
        evil-matchit
        evil-commentary
        evil-surround
        evil-escape

        smart-mode-line
        relative-line-numbers
        fill-column-indicator
        sublime-themes

        flycheck
        auto-complete
        magit
        ))

(package-initialize)

; Fetch the List of Packages Available
(unless package-archive-contents
  (package-refresh-contents))

; Install Missing Packages
(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))


; Key Bindings / Settings
; Make C-u work like in Vim
(setq evil-want-C-u-scroll t)


; Appearance
; Don't display startup messages
(setq inhibit-startup-message t)

; Disable menu
(menu-bar-mode -99)
; Disable toolbar
(tool-bar-mode -1)
; Disable scroll bar
(ignore-errors(scroll-bar-mode -1))

; Highlight the current line
(global-hl-line-mode 1)

; Theme
(load-theme 'wombat t)


; Plugins
; Evil mode
(require 'evil)
(evil-mode t)

; Evil Leader
(require 'evil-leader)

; Evil Matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)

; Evil Commentary
(require 'evil-commentary)
(evil-commentary-mode)

; Smart Mode Line
(setq sml/no-confirm-load-theme t)
(setq sml/theme 'dark)
(sml/setup)

; Sublime Themes
(require 'sublime-themes)

; Evil Surround
(require 'evil-surround)
(global-evil-surround-mode 1)

; Flychecker
(global-flycheck-mode)

; Autocomplete
(ac-config-default)


; Misc
; Relative Line Numbers
(global-relative-line-numbers-mode)
(defun relative-abs-line-numbers-format (offset)
  "The default formatting function.
  Return the absolute value of OFFSET, converted to string."
  (if (= 0 offset)
    (number-to-string (line-number-at-pos))
    (number-to-string (abs offset))))
(setq relative-line-numbers-format 'relative-abs-line-numbers-format)

; Add a space between line number and buffer
(setq linum-format "%d ")

; Disable bell
(setq ring-bell-function 'ignore)

; Backups
(setq
  backup-by-copying t
  backup-directory-alist
  '(("." . "~/.emacs.d/backups"))
  delete-old-versions t
  kept-new-versions 6
  kept-old-versions 2
  version-control t)

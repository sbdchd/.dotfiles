;; -*- mode: emacs-lisp -*-

(defun dotspacemacs/layers ()
  "Configuration Layers declaration.
You should not put any user code in this function besides modifying the variable
values."
  (setq-default
   dotspacemacs-distribution 'spacemacs
   dotspacemacs-configuration-layer-path '()
   dotspacemacs-configuration-layers
   '(
     ;; languages
     emacs-lisp
     extra-langs
     haskell
     html
     java
     javascript
     latex
     lua
     markdown
     python
     sql
     typescript
     vimscript
     yaml
     (go :variables gofmt-command "goimports")

     typography

     colors

     osx

     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom
            shell-default-shell 'ansi-term
            shell-default-term-shell "/usr/local/bin/bash")

     auto-completion
     spell-checking
     (syntax-checking :variables syntax-checking-use-original-bitmaps t)

     git
     )

   dotspacemacs-additional-packages
   '(
     diff-hl
     ;; language(s)
     applescript-mode

     ;; utils
     editorconfig
     fzf
     vdiff

     )

   dotspacemacs-excluded-packages
   '(
     evil-search-highlight-persist
     evil-esc
     yasnippet
     vi-tilde-fringe
     )

   dotspacemacs-delete-orphan-packages t
   ))

(defun dotspacemacs/init ()
  ;; This setq-default sexp is an exhaustive list of all the supported
  ;; spacemacs settings.
  (setq-default
   dotspacemacs-elpa-https t
   dotspacemacs-elpa-timeout 5
   dotspacemacs-check-for-update nil ;; speeds up startup
   dotspacemacs-verbose-loading nil

   dotspacemacs-editing-style 'vim

   dotspacemacs-startup-banner 'official
   dotspacemacs-startup-lists '(recents bookmarks projects)
   dotspacemacs-startup-recent-list-size 5

   dotspacemacs-scratch-mode 'text-mode

   dotspacemacs-themes '(solarized-light)
   dotspacemacs-colorize-cursor-according-to-state nil ;; a bit glitchy when enabled
   dotspacemacs-default-font
   '(
     "Source Code Pro"
     :size 13
     :weight normal
     :width normal
     :powerline-scale 1.1
     )

   dotspacemacs-leader-key "SPC"
   dotspacemacs-emacs-leader-key "M-m"
   dotspacemacs-major-mode-leader-key ","
   dotspacemacs-major-mode-emacs-leader-key "C-M-m"
   dotspacemacs-distinguish-gui-tab t ;; enable such that <C-i> jumps forward in jump list
   dotspacemacs-command-key ":"

   dotspacemacs-remap-Y-to-y$ t

   ;; Consider layout = workspace, workspace = layout
   dotspacemacs-default-layout-name "default"
   dotspacemacs-display-default-layout nil
   dotspacemacs-auto-resume-layouts t

   dotspacemacs-auto-save-file-location nil
   dotspacemacs-max-rollback-slots 5

   dotspacemacs-use-ido nil
   dotspacemacs-helm-resize nil
   dotspacemacs-helm-no-header nil
   dotspacemacs-helm-position 'bottom

   dotspacemacs-enable-paste-micro-state t

   dotspacemacs-which-key-delay 0.4
   dotspacemacs-which-key-position 'bottom

   ;; spacemacs startup settings
   dotspacemacs-loading-progress-bar t
   dotspacemacs-fullscreen-at-startup nil
   dotspacemacs-fullscreen-use-non-native nil
   dotspacemacs-maximized-at-startup t

   dotspacemacs-active-transparency 90
   dotspacemacs-inactive-transparency 90

   dotspacemacs-mode-line-unicode-symbols nil
   dotspacemacs-smooth-scrolling t
   dotspacemacs-line-numbers 'relative

   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all

   dotspacemacs-persistent-server t

   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()
  ;; indicate empty lines
  (defun enable-indicate-empty-lines ()
    (interactive)
    (unless (minibufferp)
      (setq indicate-empty-lines t)))
  (add-hook 'text-mode-hook 'enable-indicate-empty-lines)
  (add-hook 'prog-mode-hook 'enable-indicate-empty-lines)

  ;; persistent undo
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

  ;; font for all unicode characters
  ;; http://stackoverflow.com/a/22656515/3720597
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

  ;; theme setup
  (setq solarized-distinct-fringe-background t)
  (setq solarized-emphasize-indicators nil)

  ;; git gutter style change highlighting
  (defun enable-diff-hl-mode ()
    (when (fboundp 'diff-hl-mode)
      (diff-hl-mode)
      (diff-hl-flydiff-mode)))
    (add-hook 'text-mode-hook 'enable-diff-hl-mode)
    (add-hook 'prog-mode-hook 'enable-diff-hl-mode)
    (add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

  ;; magit
  ;; 2 way diff (default 3) with ediff via magit
  (setq magit-ediff-dwim-show-on-hunks t)

  ;; term mode stuff
  (defun sbdchd/setup-term-mode ()
    "setup C-r to work in term-mode"
    (evil-local-set-key 'insert (kbd "C-r") 'sbdchd/send-C-r))
  (defun sbdchd/send-C-r ()
    "send C-r to the terminal raw"
    (interactive)
    (term-send-raw-string "\C-r"))
  (add-hook 'term-mode-hook 'sbdchd/setup-term-mode)

  )

(defun dotspacemacs/user-config ()

  (defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
    "Prevent annoying \"Active processes exist\" query when you quit Emacs."
    (flet ((process-list ())) ad-do-it))

  ;; set title of emacs window
  (setq frame-title-format
        '(buffer-file-name "%f" (dired-directory dired-directory "%b")))

  ;; update file if changed on disk (only works if buffer isn't modified)
  (global-auto-revert-mode t)

  ;; modeline
  (setq powerline-default-separator nil)
  (spaceline-compile)

  ;; fzf
  (defadvice fzf/start (after normalize-fzf-mode-line activate)
    "Hide the modeline so FZF will render properly."
    (setq mode-line-format nil))
  (spacemacs/set-leader-keys "fz" 'fzf)

  (setq-default

   ;; evil mode
   evil-shift-round nil ;; make << or >> shift by a constant amount
   evil-move-cursor-back nil
   evil-cross-lines t ;; make `f` work across lines

   ;; terminal
   term-suppress-hard-newline t

   )
  )

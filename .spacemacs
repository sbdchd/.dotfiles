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
     dockerfile
     emacs-lisp
     extra-langs
     haskell
     html
     java
     javascript
     latex
     lua
     markdown
     nixos
     org
     python
     sql
     swift
     typescript
     vimscript
     yaml
     (rust :variables rust-enable-racer t)
     (go :variables gofmt-command "goimports")

     command-log
     typography

     osx

     ;; project management
     gtags
     eyebrowse

     (shell :variables
            shell-default-height 30
            shell-default-position 'bottom)

     auto-completion
     spell-checking
     syntax-checking

     ;; version control
     (git :variables git-gutter-use-fringe t)
     version-control
     )

   dotspacemacs-additional-packages
   '(
     ;; languages
     moonscript
     applescript-mode

     ;; utils
     editorconfig
     fzf

     ;; git
     mo-git-blame
     )

   dotspacemacs-excluded-packages
   '(
     evil-search-highlight-persist
     yasnippet
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

   dotspacemacs-themes
   '(
     solarized-light
     brin
     )
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

   ;; Info about layouts vs workspaces b.c. they are confusing
   ;; https://github.com/syl20bnr/spacemacs/blob/develop/doc/DOCUMENTATION.org#layouts-and-workspaces
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
   dotspacemacs-line-numbers nil

   dotspacemacs-smartparens-strict-mode nil
   dotspacemacs-highlight-delimiters 'all

   dotspacemacs-persistent-server t

   dotspacemacs-default-package-repository nil
   dotspacemacs-whitespace-cleanup 'changed
   ))

(defun dotspacemacs/user-init ()

;;; timestamps in *Messages*
  (defun current-time-microseconds ()
    (let* ((nowtime (current-time))
           (now-ms (nth 2 nowtime)))
      (concat (format-time-string "[%Y-%m-%dT%T" nowtime) (format ".%d] " now-ms))))

  (defadvice message (before test-symbol activate)
    (if (not (string-equal (ad-get-arg 0) "%s%s"))
        (let ((deactivate-mark nil)
              (inhibit-read-only t))
          (save-excursion
            (set-buffer "*Messages*")
            (goto-char (point-max))
            (if (not (bolp))
                (newline))
            (insert (current-time-microseconds))))))

  ;; persistent undo
  (setq undo-tree-auto-save-history t
        undo-tree-history-directory-alist
        `(("." . ,(concat spacemacs-cache-directory "undo"))))
  (unless (file-exists-p (concat spacemacs-cache-directory "undo"))
    (make-directory (concat spacemacs-cache-directory "undo")))

  ;; font for all unicode characters
  ;; http://stackoverflow.com/a/22656515/3720597
  (set-fontset-font t 'unicode "Apple Color Emoji" nil 'prepend)

  ;; make workspaces (persp-mode) save and restore automatically
  ;; https://www.gnu.org/software/emacs/manual/html_node/emacs/Saving-Emacs-Sessions.html#Saving-Emacs-Sessions
  ;; (desktop-save-mode 1) ;; TODO

  )

(defun dotspacemacs/user-config ()
  ;; modeline
  (setq powerline-default-separator nil)
  (spaceline-compile)

  ;; make j & k work like gj & gk in vim
  (define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
  (define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)

  ;; fzf
  (defadvice fzf/start (after normalize-fzf-mode-line activate)
    "Hide the modeline so FZF will render properly."
    (setq mode-line-format nil))
  (spacemacs/set-leader-keys "fz" 'fzf)

  (setq-default

   ;; version control
   vc-follow-symlinks t

   ;; evil mode
   evil-shift-round nil ;; make << or >> shift by a constant amount
   evil-move-cursor-back nil
   evil-cross-lines t ;; make `f` work across lines

   ;; shell
   shell-default-shell 'shell

   )
  )

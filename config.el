;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; These are used for a number of things, particularly for GPG configuration,
;; some email clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; test
(setq doom-font (font-spec :family "Hack Nerd Font Mono" :size 20)
      doom-variable-pitch-font (font-spec :family "sans"))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-one)

;; this to fix ‘max-lisp-eval-depth’ error
(setq max-specpdl-size 5000
      max-lisp-eval-depth 2500)

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type 'relative)
(add-hook! doom-scratch-buffer-hook (lambda ()
  (setq display-line-numbers-type 'relative
        display-line-numbers-mode t)))

;; this crap for word wrapping
(global-visual-line-mode 1)
(setq truncate-lines nil)
; (setq-default auto-fill-function 'do-auto-fill)
; (add-hook 'text-mode-hook 'turn-on-visual-line-mode)

;; this is for folding
(evil-vimish-fold-mode 1)

;; snippets
; (yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)
(yas-global-mode 1)
(setq yas-snippet-dirs '("~/.doom.d/snippets"))

;; this is for markdown mode
(require 'markdown-mode)
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;; time to show auto suggestions
(setq company-idle-delay 0)

;;;;;;;;;;;;;;
;;;; ORG shiz
;;;;;;;;;;;;;
;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/org/")
;; highlight for latex code
(eval-after-load 'org
  '(setf org-highlight-latex-and-related '(latex script entities)))
;; latex code previews
; (setq org-latex-create-formula-image-program 'dvisvgm)
;; pdf previews
; (add-to-list 'image-type-file-name-regexps '("\\.pdf\\'" . imagemagick))
; (add-to-list 'image-file-name-extensions "pdf")
; (setq imagemagick-types-inhibit (remove 'PDF imagemagick-types-inhibit))
; (setq org-image-actual-width 600)
; (use-package org-include-img-from-pdf
  ; :load-path "elisp/org-include-img-from-pdf"
  ; :config
  ; (progn
    ; (with-eval-after-load 'ox
      ; (add-hook 'org-export-before-processing-hook #'org-include-img-from-pdf))))
;; crap for mic-paren - latex highlight
; (require 'mic-paren) ; loading
; (paren-activate)     ; activating
; (setq org-src-fontify-natively t)

;; If you want to attempt to auto-convert PDF to PNG  only during exports, and not during each save.
;; (with-eval-after-load 'ox
;;   (add-hook 'org-export-before-processing-hook #'org-include-img-from-pdf))

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Keybidings for myself
;; org mode
;; bind multiple keys
(map! :ne "C-s" #'basic-save-buffer)
(map! :ne "C-q" #'save-buffers-kill-emacs)
(map! :leader
      :desc "Export to latex-pdf" "e" #'org-latex-export-to-pdf)
(map! :leader
      (:prefix-map ("l" . "Latex code preview")
        :desc "Latex mode" "m" #'latex-mode
        :desc "Org mode" "o" #'org-mode
        :desc "Preview images" "i" #'org-display-inline-images
        :desc "Latex math preview" "p" #'org-latex-preview))
        ;; :desc "Latex math preview" "p" #'px-toggle))

(defun comment-line-changed()
  (interactive)
  (comment-line 1)
  (forward-line -1)
  )
(map! :nv "SPC c SPC " #'comment-line-changed)
(map! :leader "/" #'comment-line)

(defun paste-to-new-line()
  "Paste from clipboard to a new line"
  (interactive)
  (evil-open-below())
  (evil-paste-after())
  (evil-escape)
  )
;; (unmap! "S-p")
;; (map! [(shift p)] #'paste-to-new-line)
(map! "M-p" #'paste-to-new-line)
(map! [(control shift c)]  #'evil-yank)
(map! [(control shift v)]  #'evil-paste-after)

(defun move-line-up ()
  "Move up the current line."
  (interactive)
  (transpose-lines 1)
  (forward-line -2)
  (indent-according-to-mode))
(defun move-line-down ()
  "Move down the current line."
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
  (forward-line -1)
  (indent-according-to-mode))
;; (global-set-key [(control shift up)]  'move-line-up)
;; (global-set-key [(control shift down)]  'move-line-down)
(map! [(control shift w)]  #'move-line-up)
(map! [(control shift s)]  #'move-line-down)

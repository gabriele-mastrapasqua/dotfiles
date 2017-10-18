
;; UTF-8 please
(setq locale-coding-system 'utf-8) ; pretty
(set-terminal-coding-system 'utf-8) ; pretty
(set-keyboard-coding-system 'utf-8) ; pretty
(set-selection-coding-system 'utf-8) ; please
(prefer-coding-system 'utf-8) ; with sugar on top
;;(define-coding-system-alias 'UTF-8 'utf-8) ; alias for python files coding declaration. remove warnings 'do you really want to save file?

;; Don't defer screen updates when performing operations
(setq redisplay-dont-pause t)

;; Compile el files after saving them
(add-hook 'after-save-hook
          (lambda ()
            (if (eq major-mode 'emacs-lisp-mode)
                (save-excursion (byte-compile-file buffer-file-name)))))

(blink-cursor-mode 0)
(mouse-wheel-mode t)
(setq require-final-newline t) 
(cua-mode 1)  ;; C-z,C-x,...
(delete-selection-mode 1)  ;; replace highlighted region when typing
(transient-mark-mode t)              ;; No region when it is not highlighted
;;(setq cua-keep-region-after-copy -1)  ;; after a copy disable the selection because otherwise other commands (es cut) will go to the region...

;; smooth scroll 
(setq scroll-step 1)
(setq scroll-conservatively 10000)
(setq auto-window-vscroll nil)
(setq mouse-wheel-scroll-amount '(4 ((shift) . 4) ((control) . nil)))
(setq mouse-wheel-progressive-speed nil)

(setq-default fill-column 80)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;;(menu-bar-mode -1)
(global-linum-mode 1)
(fset 'yes-or-no-p 'y-or-n-p)  ;; Always y/n

(setq-default tab-width 4)
(setq-default indent-tabs-mode nil) ;; Always use spaces when indenting (unless overridden for buffer)
(setq-default python-indent-offset tab-width)

; Wrap lines without splitting off words
(setq-default word-wrap t)

;; scratch buffer empty
(setq initial-scratch-message nil)

;; set scratch as text-mode (for speed)
(setq initial-major-mode 'text-mode)

;; Don't show startup screen
(setq inhibit-splash-screen t)
(put 'overwrite-mode 'disabled t)

(setq
 delete-by-moving-to-trash t
 create-lockfiles nil
 gc-cons-threshold 20000000)

;; no bell
(custom-set-variables '(ring-bell-function 'ignore))
(setq visible-bell nil)

;; default window size and position
(if (window-system)
    (setq default-frame-alist
          (append (list
                   '(width . 175)
                   '(height . 52)
                   '(top . 10)
                   '(left . 150)
                  )
                  default-frame-alist)))

(setq column-number-mode t)
(setq make-backup-files nil) ;; stop creating backup~ files
(setq auto-save-default nil) ;; stop creating #autosave# files

;; Font options
(if window-system
      (set-face-attribute 'default nil :font "DejaVu Sans Mono-9"))

;;auto reload files that have changed
(global-auto-revert-mode t)

;; set window title as file currently edited
(setq frame-title-format '(buffer-file-name "Emacs: %b (%f)" "Emacs: %b"))

;; when re load-theme, reset previous theme's colors
(defadvice load-theme 
  (before theme-dont-propagate activate)
  (mapcar #'disable-theme custom-enabled-themes))


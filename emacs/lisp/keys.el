
;; find emacs init
(global-set-key (kbd "<f8>")
                (lambda()(interactive)(find-file "~/.emacs.d/lisp/config.el")))
;; find notes
(global-set-key (kbd "<f12>")
                (lambda()(interactive)(find-file "~/source/note/notes.org")))



(global-set-key [C-tab] 'other-window)
;;(global-set-key [C-right] 'other-window)
(global-set-key "\C-a" 'mark-whole-buffer)

;; visual regexp using python/perl regexpr! use this for the python regexpr
;; for example replace ^[a-z]+$ will work
(require 'visual-regexp-steroids)
(global-set-key "\C-h" 'vr/query-replace)
;;(global-set-key "\C-f" 'vr/isearch-forward)  ;; search case *sensitive* also with python regexpr
;;(global-set-key [f3] 'vr/isearch-forward)
(global-set-key "\C-f" 'isearch-forward)  ;; normal emacs search function case *insensitive* is good
(global-set-key [f3] 'isearch-forward)

;; map ESC like C-g like in vim to exit a command
(global-set-key [escape] 'keyboard-escape-quit)


;; create an empty buffer and switch to it
(defun new-empty-buffer ()
  "Open a new empty buffer."
  (interactive)
  (let ((buf (generate-new-buffer "untitled")))
    (switch-to-buffer buf)
    (funcall (and initial-major-mode))
    (setq buffer-offer-save t)))

;; save and kill buffer
(defun save-and-kill-buffer()
  (interactive)
  (save-buffer)
  (kill-buffer (current-buffer)))

(global-set-key "\C-q" 'kill-emacs)
(global-set-key "\C-w" 'save-and-kill-buffer)
(global-set-key "\C-n" 'new-empty-buffer)
(global-set-key "\C-o" 'find-file)
(global-set-key "\C-s" 'save-buffer)
(define-key global-map (kbd "RET") 'newline-and-indent) ; For programming
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward) ; repeat last search
(define-key isearch-mode-map [f3] 'isearch-repeat-forward) ; repeat last search

;; C-d like notepad++
(defun duplicate-current-line ()
  (interactive)
  (beginning-of-line nil)
  (let ((b (point)))
    (end-of-line nil)
    (copy-region-as-kill b (point)))
  (beginning-of-line 2)
  (open-line 1)
  (yank)
  (back-to-indentation))
(global-set-key "\C-d" 'duplicate-current-line)

;; enable mouse click + Shift for selection
(define-key global-map (kbd "<S-down-mouse-1>") 'mouse-save-then-kill)

;; notepad++ highlight a symbol when doubleclicked, remove when click away.
(require 'highlight-symbol)
(setq highlight-symbol-colors '("yellow"))
(defun highlight-words ()
  (when (not (eq (buffer-file-name) nil))
    ;; when you are editing a real file (not activate on the modeline)
    (highlight-symbol-remove-all)  ;; clear old highlights
    (highlight-symbol-at-point))
  )
;; run after 0.5s and don't repeat(-1)
(setq highlight-timer (run-with-idle-timer 0.5 -1 'highlight-words))
;;(global-set-key [mouse-1] 'highlight-words)


;; M-x with autocomplete!
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

;; expand region keys
(global-set-key (kbd "C-,") 'er/expand-region)
(global-set-key (kbd "C-M-,") 'er/contract-region)

;; ace-jump-mode
(global-set-key (kbd "C-;") 'ace-jump-mode)
(global-set-key (kbd "C-:") 'ace-jump-word-mode)

;;magit
;;(global-set-key (kbd "C-m") 'magit-status)
(global-set-key (kbd "C-n") 'magit-status)

;;text-size
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)

;; ECB with customizations
;; right speedbar
(defun ecb-show ()
  (interactive)
  (require 'ecb)
  (setq ecb-primary-secondary-mouse-buttons (quote mouse-1--C-mouse-1)) ;; use mouse1 for selection
  (setq ecb-tip-of-the-day nil) ;; dont show a messagebox at startup
  (setq ecb-auto-compatibility-check nil) ;; dont show an upgrade message at startup
  (setq ecb-windows-width 20)
  ;;(ecb-toggle-ecb-windows)
  (ecb-activate) ;; shows it
  )
;;(ecb-show)
(global-set-key (kbd "<f7>") 'ecb-show)



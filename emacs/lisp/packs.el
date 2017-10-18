;; Packages
(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")
                         ))
(package-initialize)

;; auto install missing packages!
(defvar my-packages
  '(org nav
        ;; Major modes
        rainbow-mode web-mode markdown-mode
        ;; Other plugins
        visual-regexp-steroids smartparens highlight-symbol 
        rainbow-delimiters magit auto-complete ag highlight-indentation
        auto-complete-nxml flycheck ido flyspell paredit 
        sr-speedbar smex undo-tree expand-region ace-jump-mode
        projectile smartscan yasnippet flx-ido
        ido-ubiquitous ido-vertical-mode leuven-theme
        
        ))
(defun packages-installed-p ()
  (not (memq 'nil (mapcar (lambda (p) (package-installed-p p)) my-packages))))
(unless (packages-installed-p)
  (package-refresh-contents)
;; install the missing packages
  (dolist (p my-packages)
    (when (not (package-installed-p p))
      (package-install p))))
(provide 'packages)

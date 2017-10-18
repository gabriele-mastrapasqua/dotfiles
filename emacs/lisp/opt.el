
(setq inferior-lisp-program "/usr/bin/sbcl")

;;; Mode file mapping
(setq auto-mode-alist
      (append '(("\\.md\\'" . markdown-mode)
                ("\\.\\(yaml\\|yml\\)$" . yaml-mode)
                ("\\.clj$" . clojure-mode)
                ("\\.as$" . c++-mode)
                ("\\.sql$" . sql-mode)
                ("\\.\\(rb\\|Gemfile\\|Vagrantfile\\|Rakefile\\)$" . enh-ruby-mode)
                ("\\.hs$" . haskell-mode)
                ;; Web modes
                ("\\.html$" . web-mode)
                ("\\.tmpl$" . web-mode)
                ("\\.eco$" . web-mode)
                ("\\.scss$" . sass-mode))
              auto-mode-alist))


;; templates,html,js,css mode
(require 'web-mode)
(setq web-mode-markup-indent-offset 2)

(require 'rainbow-mode)
(rainbow-delimiters-mode 1)
(show-smartparens-global-mode 1)  ;; color parens


;; python JEDI autocomplete server
;; 1) sudo pip install jedi
;; 2) M-x jedi:install-server
;; 3) M-x jedi:setup-jedi
;;
;; if not works intall jedi emacs package from packages-list (will use recent version)
(autoload 'jedi:setup "jedi" nil t)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

;;(require 'projectile)
;;(projectile-global-mode)
;;(setq projectile-indexing-method 'native)
;;(setq projectile-enable-caching t)

;; setup autocomplete
(require 'auto-complete-config)
(ac-config-default)
(setq ac-ignore-case t)
(global-auto-complete-mode t)
(setq ac-auto-start t) ;; start autocomplete automatically
(add-to-list 'ac-modes 'web-mode)
(add-to-list 'ac-modes 'org-mode)  ;; enable autocomplete on org-mode
(ac-set-trigger-key "TAB") ;; map TAB to autocomplete

;; auto insert parens or brackets
;;(electric-pair-mode 1)

;; ido-mode
(require 'ido)
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; will make uniques names when 2 buffers have same name
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)


;; Highlight current line
(global-hl-line-mode 1)


;;better undo
;;(require 'undo-tree)
;;(global-undo-tree-mode 1)


;;expand selection
(require 'expand-region)

;; jump to definition
(require 'ace-jump-mode)

;;; Themes
(defun theme-dark()
  (load-theme 'tango t)
  )
(defun theme-light()
  ;; in term adwaita is better and similar to leuven
  (load-theme 'leuven t)
  
  ;; bck as in soft-morning, is more eye friendly
  (add-to-list 'default-frame-alist '(background-color . "#f2f1f0"))
  (add-to-list 'default-frame-alist '(background-color . "#eeeeee")))

(if (window-system)
    (theme-light)
  (theme-dark))


;; call py to beautify json in buffer
(defun json-format ()
  (interactive)
  (save-excursion (shell-command-on-region (mark) (point) "python -m json.tool" (buffer-name) t)))


;; Org-mode
(setq org-agenda-files '("~/source/note")) ;; org default folder
(setq  org-startup-indented t)  ;; use auto indent based on stars
(require 'org-mouse)
(setq org-replace-disputed-keys t) ;; stop hijacking Shift-cursor keys
(setq org-support-shift-select t)  ;; allow using CTRL-Shift for selection

;; active org-Babel languages: enable langs embedded in org-mode
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (ruby . t)
   ))


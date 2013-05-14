;;; Basic ruby setup
(require-package 'ruby-mode)
(require-package 'ruby-hash-syntax)

(add-auto-mode 'ruby-mode
               "Rakefile\\'" "\\.rake\\'" "\.rxml\\'"
               "\\.rjs\\'" ".irbrc\\'" "\.builder\\'" "\\.ru\\'"
               "\\.gemspec\\'" "Gemfile\\'" "Kirkfile\\'")

(setq ruby-use-encoding-map nil)

(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "RET") 'reindent-then-newline-and-indent)
     (define-key ruby-mode-map (kbd "TAB") 'indent-for-tab-command)))

;; Stupidly the non-bundled ruby-mode isn't a derived mode of
;; prog-mode: we run the latter's hooks anyway in that case.
(add-hook 'ruby-mode-hook
          (lambda ()
            (unless (derived-mode-p 'prog-mode)
              (run-hooks 'prog-mode-hook))))



;;; Inferior ruby
(require-package 'inf-ruby)
(autoload 'run-ruby "inf-ruby" "Run an inferior Ruby process")



;;; Ruby compilation
(require-package 'ruby-compilation)

(eval-after-load 'ruby-mode
 '(let ((m ruby-mode-map))
    (define-key m [S-f7] 'ruby-compilation-this-buffer)
    (define-key m [f7] 'ruby-compilation-this-test)
    (define-key m [f6] 'recompile)))



;;; Ruby flymake
(require-package 'flymake-ruby)
(add-hook 'ruby-mode-hook 'flymake-ruby-load)



;;; Robe
(require-package 'robe)
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'robe-mode-hook
          (lambda ()
            (add-to-list 'ac-sources 'ac-source-robe)
            (set-auto-complete-as-completion-at-point-function)))



;;; ri support
(require-package 'yari)
(defalias 'ri 'yari)



;;; YAML

(require-package 'yaml-mode)
(require-package 'flymake-yaml)
(add-hook 'yaml-mode-hook 'flymake-yaml-load)



;;; Rails
(require-package 'rinari)
(eval-after-load 'rinari
  '(diminish 'rinari-minor-mode "Rin"))
(require-package 'haml-mode)



;;; ERB
(require-package 'mmm-mode)
(defun sanityinc/ensure-mmm-erb-loaded ()
  (require 'mmm-erb))

(require 'derived)

(defun sanityinc/set-up-mode-for-erb (mode)
  (add-hook (derived-mode-hook-name mode) 'sanityinc/ensure-mmm-erb-loaded)
  (mmm-add-mode-ext-class mode "\\.erb\\'" 'erb))

(let ((html-erb-modes '(html-mode html-erb-mode nxml-mode)))
  (dolist (mode html-erb-modes)
    (sanityinc/set-up-mode-for-erb mode)
    (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-js)
    (mmm-add-mode-ext-class mode "\\.r?html\\(\\.erb\\)?\\'" 'html-css)))

(mapc 'sanityinc/set-up-mode-for-erb
      '(coffee-mode js-mode js2-mode js3-mode markdown-mode textile-mode))

(require-package 'tagedit)
(eval-after-load "sgml-mode"
  '(progn
     (tagedit-add-paredit-like-keybindings)))

(mmm-add-mode-ext-class 'html-erb-mode "\\.jst\\.ejs\\'" 'ejs)

(add-auto-mode 'html-erb-mode "\\.rhtml\\'" "\\.html\\.erb\\'")
(add-to-list 'auto-mode-alist '("\\.jst\\.ejs\\'"  . html-erb-mode))
(mmm-add-mode-ext-class 'yaml-mode "\\.yaml\\'" 'erb)

(dolist (mode (list 'js-mode 'js2-mode 'js3-mode))
  (mmm-add-mode-ext-class mode "\\.js\\.erb\\'" 'erb))


;;----------------------------------------------------------------------------
;; Ruby - my convention for heredocs containing SQL
;;----------------------------------------------------------------------------

;; Needs to run after rinari to avoid clobbering font-lock-keywords?

;; (require-package 'mmm-mode)
;; (eval-after-load 'mmm-mode
;;   '(progn
;;      (mmm-add-classes
;;       '((ruby-heredoc-sql
;;          :submode sql-mode
;;          :front "<<-?[\'\"]?\\(end_sql\\)[\'\"]?"
;;          :save-matches 1
;;          :front-offset (end-of-line 1)
;;          :back "^[ \t]*~1$"
;;          :delimiter-mode nil)))
;;      (mmm-add-mode-ext-class 'ruby-mode "\\.rb\\'" 'ruby-heredoc-sql)))

;(add-to-list 'mmm-set-file-name-for-modes 'ruby-mode)



(provide 'init-ruby-mode)

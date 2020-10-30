;;; init-lsp.el --- Lsp config -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package lsp-mode
  :ensure t
  :commands (lsp lsp-deferred lsp-enable-which-key-integration)
  :init
  ;; @see https://github.com/emacs-lsp/lsp-mode#performance
  (setq read-process-output-max (* 50 (* 1024 1024)))  ;; 50MB
  (setq lsp-keymap-prefix "C-c l")
  (setq lsp-prefer-flymake nil) ;; Prefer using lsp-ui (flycheck) over flymake.
  ;; (setq lsp-gopls-use-placeholders t)
  (setq lsp-enable-snippet t)
  (setq lsp-log-io nil)
  ;; (setq lsp-prefer-capf t)
  (setq lsp-enable-file-watchers nil)
  ;; (setq lsp-diagnostic-package :none) ;; no realtime syntax check
  (setq lsp-restart 'auto-restart)
  :config
  (setq lsp-gopls-server-args '("serve" "-rpc.trace" "--debug=localhost:6060"))
  :hook
  (go-mode . lsp-deferred)
  (rust-mode . lsp-deferred)
  (python-mode . lsp-deferred))

(use-package lsp-treemacs
  :ensure t
  :after lsp-mode
  :commands lsp-treemacs-errors-list
  :config
  (with-eval-after-load 'ace-window
    (when (boundp 'aw-ignored-buffers)
      (push 'lsp-treemacs-symbols-mode aw-ignored-buffers)
      (push 'lsp-treemacs-java-deps-mode aw-ignored-buffers))))

(use-package lsp-ui
  :ensure t
  :requires lsp-mode flycheck
  :commands lsp-ui-mode
  :init
  (setq lsp-eldoc-enable-hover nil)
  (setq lsp-ui-imenu-enable t)
  (setq lsp-ui-doc-include-signature t)
  (setq lsp-ui-doc-enable t
        lsp-ui-doc-use-childframe t
        lsp-ui-doc-position 'top
        lsp-ui-doc-include-signature t
        lsp-ui-sideline-enable t
        lsp-ui-flycheck-enable t
        lsp-ui-flycheck-list-position 'bottom
        lsp-ui-flycheck-live-reporting t
        lsp-ui-peek-enable t
        lsp-ui-peek-list-width 80
        lsp-ui-peek-peek-height 35)
  :config
  (add-hook 'lsp-mode-hook 'lsp-ui-mode))

;; (use-package company-lsp
;;   :ensure t
;;   :requires company
;;   :commands company-lsp
;;   :config
;;   (push 'company-lsp company-backends)

;;   ;; Disable client-side cache because the LSP server does a better job.
;;   (setq company-transformers nil
;;         company-lsp-enable-snippet t
;;         company-lsp-async t
;;         company-lsp-enable-recompletion t
;;         company-lsp-cache-candidates nil))

(provide 'init-lsp)
;;; init-lsp.el ends here

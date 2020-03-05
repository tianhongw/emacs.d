;;; init-golang.el --- Support for the Golang language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package go-mode
  :ensure t
  :after xref
  :mode (("\\.go\\'" . go-mode))
  :hook (before-save . gofmt-before-save)
  :bind (:map go-mode-map
              ("C-j" . xref-find-definitions-other-window)
              ("C-c C-j" . lsp-find-definition)
              ("C-c C-t" . 'save-and-test-program))
  :init
  (setq gofmt-command "goimports"))

(use-package go-eldoc
  :ensure t
  :init
  (add-hook 'go-mode-hook 'go-eldoc-setup))

(defun save-and-test-program()
  (interactive)
  (save-some-buffers t)
  (compile "go test -v -cover -coverprofile=/tmp/c -covermode=count"))

(provide 'init-golang)
;;; init-golang.el ends here

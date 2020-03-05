;;; init-yasnippet.el --- Yasnippet -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

(use-package yasnippet
  :ensure t
  :config
  (yas-global-mode 1)
  (setq yas-snippet-dirs
        '("~/.emacs.d/snippets")))

(provide 'init-yasnippet)
;;; init-yasnippet.el ends here

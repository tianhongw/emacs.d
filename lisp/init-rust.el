;;; init-rust.el --- Support for the Rust language -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:

;; (when (maybe-require-package 'rust-mode)
;;   (when (maybe-require-package 'racer)
;;     (add-hook 'rust-mode-hook #'racer-mode))
;;   (when (maybe-require-package 'company)
;;     (add-hook 'racer-mode-hook #'company-mode)))

(when (maybe-require-package 'flycheck-rust)
  (after-load 'rust-mode
    (add-hook 'flycheck-mode-hook #'flycheck-rust-setup)))

(use-package rust-mode
  :ensure t
  :bind (:map rust-mode-map
              ("C-j" . xref-find-definitions-other-window))
  :config
  (setq rust-format-on-save t))

(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode))

(use-package flycheck-rust
  :ensure t)

(provide 'init-rust)
;;; init-rust.el ends here

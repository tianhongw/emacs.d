;;; init-python.el --- Python editing -*- lexical-binding: t -*-
;;; Commentary:
;;; Code:


;; See the following note about how I set up python + virtualenv to
;; work seamlessly with Emacs:
;; https://gist.github.com/purcell/81f76c50a42eee710dcfc9a14bfc7240


(setq auto-mode-alist
      (append '(("SConstruct\\'" . python-mode)
                ("SConscript\\'" . python-mode))
              auto-mode-alist))

(setq python-shell-interpreter "python3")

(require-package 'pip-requirements)

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "C-j") #'xref-find-definitions-other-window)))

(add-hook 'python-mode-hook
          (lambda () (local-set-key (kbd "C-c C-j") #'lsp-find-definition)))

(provide 'init-python)
;;; init-python.el ends here

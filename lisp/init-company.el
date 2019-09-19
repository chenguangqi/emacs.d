;;(require 'yasnippet)
;;(yas-global-mode 1)

(add-hook 'after-init-hook 'global-company-mode)
(setq company-backends
      '(company-bbdb
        company-eclim company-semantic
        company-capf company-files
        (company-dabbrev-code company-gtags company-etags company-keywords)
        company-oddmuse company-dabbrev))
(setq company-show-numbers t)

(provide 'init-company)

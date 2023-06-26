(put 'projectile-ripgrep 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-candidate-number-limit 10000)
 '(package-selected-packages '(company-terraform terraform-mode helm-gtags)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(setq  helm-rg--glob-string "")
(setq  helm-rg--glob-string "!{vendor,git}")
(setq  helm-rg--extra-args "-uu")
;; (setq  helm-rg--extra-args nil)

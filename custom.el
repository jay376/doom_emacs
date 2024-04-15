(put 'projectile-ripgrep 'disabled nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-candidate-number-limit 10000)
 '(package-selected-packages
   '(helm-rg helm-org helm-make helm company-terraform terraform-mode helm-gtags))
 '(persp-remove-buffers-from-nil-persp-behaviour nil)
 '(persp-reset-windows-on-nil-window-conf nil)
 '(projectile-enable-caching t))
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

;; jump to compilation buffer automatically
(add-hook 'compilation-finish-functions 'switch-to-buffer-other-window 'compilation)
;; ;; jump to compilation buffer easily
;; (add-to-list 'display-buffer-alist
;;              '("\\*compilation\\*" display-buffer-in-side-window
;;                (side . bottom) (slot . -1)))

(global-set-key (kbd "M-x") 'counsel-M-x)

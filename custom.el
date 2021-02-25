;; customized varible
;; projectile-globally-ignored-directories, which set project grep  filter directory
;; lsp-file-watch-ignored
;; helm-make-arguments

;; basic
(global-set-key (kbd "M-p")         (quote copy-paragraph))
(global-set-key (kbd "M-c")         (quote thing-copy-string-to-mark))
(global-set-key (kbd "M-s M-s") 'new-shell)
(global-set-key ( kbd "C-\\") 'redo)
(global-set-key ( kbd "C-/") 'undo)
(global-set-key ( kbd "C-_") 'undo)
(global-set-key "\M-r" 'replace-string)
(global-set-key (kbd "M-s r") 'revert-buffer)
(global-set-key (kbd "M-s ,") 'rename-buffer)
(global-set-key (kbd "M-s .") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-s k") 'kill-this-buffer)
(global-set-key (kbd "M-s g") 'rgrep)
(global-set-key (kbd "M-a") 'backward-paragraph)
(global-set-key (kbd "M-e") 'forward-paragraph)
(global-set-key (kbd "M-4") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-2") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-0") 'other-window)

(global-set-key (kbd "M-s p") 'dired-up-directory)
(global-set-key (kbd "M-s e") 'eval-buffer)

(global-set-key (kbd "M-k") 'qiang-copy-line)
                                        ;switch window
(global-set-key (kbd "M--") 'switch-to-prev-buffer)
(global-set-key (kbd "M-=") 'switch-to-next-buffer)
;; delete the last space
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region)


;; 每次compile，都会确认compile-comand，禁止确认
(setq compilation-read-command nil)
;; 定位编译错误
(global-set-key (kbd "C-c n") 'next-error)

(define-key global-map (kbd "C-c c") 'smart-compile)


;; helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-x f") 'helm-find-files)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h t") 'helm-top)
(global-set-key (kbd "C-c h i") 'helm-semantic-or-imenu)

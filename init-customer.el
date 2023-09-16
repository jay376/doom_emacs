(global-set-key (kbd "M-2") 'delete-window)
(global-set-key (kbd "M-1") 'delete-other-windows)
(global-set-key (kbd "M-4") 'split-window-vertically)
(global-set-key (kbd "M-3") 'split-window-horizontally)
(global-set-key (kbd "M-0") 'other-window)
(global-set-key (kbd "M-p")         (quote copy-paragraph))
;; (global-set-key (kbd "M-c")         (quote thing-copy-string-to-mark))
(global-set-key (kbd "M-w")         (quote thing-copy-string-to-mark))
(define-key global-map (kbd "M-c") 'thing-copy-string-to-mark)
(global-set-key (kbd "M-s M-s") 'new-shell)
;; (global-set-key ( kbd "C-\\") 'redo)
(global-set-key ( kbd "C-\\") 'undo-fu-only-redo)
;; (global-set-key ( kbd "C-/") 'undo)
;; (global-set-key ( kbd "C-_") 'undo)
(global-set-key "\M-r" 'replace-string)
(global-set-key (kbd "M-s r") 'revert-buffer)
(global-set-key (kbd "M-s ,") 'rename-buffer)
(global-set-key (kbd "M-s .") 'isearch-forward-symbol-at-point)
(global-set-key (kbd "M-s k") 'kill-this-buffer)
(global-set-key (kbd "M-s g") 'rgrep)
(global-set-key (kbd "M-a") 'backward-paragraph)
(global-set-key (kbd "M-e") 'forward-paragraph)

(global-set-key (kbd "M-s p") 'dired-up-directory)
(global-set-key (kbd "M-s e") 'eval-buffer)
(global-set-key (kbd "M-s /") 'lsp-find-references)
(global-set-key (kbd "M-s i ") 'lsp-find-implementation)

(global-set-key (kbd "C-l") 'qiang-copy-line)
(global-set-key (kbd "C-k") 'kill-visual-line)
                                        ;switch window
(global-set-key (kbd "M--") 'switch-to-prev-buffer)
(global-set-key (kbd "M-=") 'switch-to-next-buffer)
;; delete the last space
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(global-set-key (kbd "M-;") 'comment-or-uncomment-region)

;;(define-prefix-command 'M-m-map)
;;(global-set-key (kbd "M-m /") '+default/search-project-for-symbol-at-point)

;; (define-key global-map (kbd "M-m") mode-specific-map)


;; 每次compile，都会确认compile-comand，禁止确认
(setq compilation-read-command nil)
;; 定位编译错误
(global-set-key (kbd "C-c n") 'next-error)
(define-key global-map (kbd "C-c c") 'smart-compile)

;; helm
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
;; (global-set-key (kbd "C-x f") 'helm-find-files)
;; (global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x b") 'helm-mini)
(global-set-key (kbd "C-x C-b") 'helm-mini)
(global-set-key (kbd "C-c h o") 'helm-occur)
(global-set-key (kbd "C-c h f") 'helm-find)
(global-set-key (kbd "C-c h t") 'helm-top)
(global-set-key (kbd "C-c h i") 'helm-semantic-or-imenu)
;; (global-set-key (kbd "M-m p s") 'projectile-run-shell)


;;;; Smart copy, if no region active, it simply copy the current whole line
(defadvice kill-line (before check-position activate)
  (if (member major-mode
              '(emacs-lisp-mode scheme-mode lisp-mode
                                c-mode c++-mode objc-mode js-mode
                                latex-mode plain-tex-mode))
      (if (and (eolp) (not (bolp)))
          (progn (forward-char 1)
                 (just-one-space 0)
                 (backward-char 1)))))

(defadvice kill-ring-save (before slick-copy activate compile)
  "When called interactively with no active region, copy a single line instead."
  (interactive (if mark-active (list (region-beginning) (region-end))
                 (message "Copied line")
                 (list (line-beginning-position)
                       (line-beginning-position 2)))))

(defadvice kill-region (before slick-cut activate compile)
  "When called interactively with no active region, kill a single line instead."
  (interactive
   (if mark-active (list (region-beginning) (region-end))
     (list (line-beginning-position)
           (line-beginning-position 2)))))

;; Copy line from point to the end, exclude the line break
(defun qiang-copy-line (arg)
  "Copy lines (as many as prefix argument) in the kill ring"
  (interactive "p")
  (kill-ring-save (point)
                  (line-end-position))
                  ;; (line-beginning-position (+ 1 arg)))
  (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

;; This buffer is for notes you don't want to save, and for Lisp evaluation.
;; If you want to create a file, visit that file with C-x C-f,
;; then enter the text in that file's own buffer.

(defun get-point (symbol &optional arg)
  "get the point"
  (funcall symbol arg)
  (point)
  )

(defun copy-thing (begin-of-thing end-of-thing &optional arg)
  "copy thing between beg & end into kill ring"
  (let ((beg (get-point begin-of-thing 1))
        (end (get-point end-of-thing arg)))
    (copy-region-as-kill beg end))
  )

(defun paste-to-mark(&optional arg)
  "Paste things to mark, or to the prompt in shell-mode"
  (let ((pasteMe
         (lambda()
           (if (string= "shell-mode" major-mode)
               (progn (comint-next-prompt 25535) (yank))
             (progn (goto-char (mark)) (yank) )))))
    (if arg
        (if (= arg 1)
            nil
          (funcall pasteMe))
      (funcall pasteMe))
    ))

(defun copy-word (&optional arg)
  "Copy words at point into kill-ring"
  (interactive "P")
  (copy-thing 'forward-word 'backward-word  arg)
  ;; (paste-to-mark arg)
       )

(defun copy-paragraph (&optional arg)
  "Copy paragraphes at point"
  (interactive "P")
  (copy-thing 'backward-paragraph 'forward-paragraph arg)
  ;; (paste-to-mark arg)
  )


(defun beginning-of-string(&optional arg)
  "  "
  (re-search-backward "[ \t]" (line-beginning-position) 3 1)
  (if (looking-at "[\t ]")  (goto-char (+ (point) 1)) )
  )
(defun end-of-string(&optional arg)
  " "
  (re-search-forward "[ \t]" (line-end-position) 3 arg)
  (if (looking-back "[\t ]") (goto-char (- (point) 1)) )
  )

(defun thing-copy-string-to-mark(&optional arg)
         " Try to copy a string and paste it to the mark
     When used in shell-mode, it will paste string on shell prompt by default "
         (interactive "P")
         (copy-thing 'beginning-of-string 'end-of-string arg)
         ;; (paste-to-mark arg)
              )
(global-set-key (kbd "M-s 1") 'insert-baidu-comment-1)
(global-set-key (kbd "M-s 2") 'insert-baidu-comment-2)
(global-set-key (kbd "M-s 3") 'insert-baidu-comment-python)
(global-set-key (kbd "M-s m") 'insert-my-comment-1)

(setq exec-path-from-shell-variables '("PATH" "MANPATH" "GOROOT"))
;; set command preffix
;; (define-prefix-command 'alt-z-map)
;; (global-set-key (kbd "M-c") 'alt-z-map)

;;;;;;;; 使用空格缩进 ;;;;;;;;
;; indent-tabs-mode  t 使用 TAB 作格式化字符  nil 使用空格作格式化字符
(setq indent-tabs-mode nil)
(setq tab-always-indent nil)
(setq tab-width 4)
(setq default-tab-width 4)
(setq-default indent-tabs-mode nil)

;; (defun redo (&optional count)
;;   "Redo the the most recent undo.
;; Prefix arg COUNT means redo the COUNT most recent undos.
;; If you have modified the buffer since the last redo or undo,
;; then you cannot redo any undos before then."
;;   (interactive "*p")
;;   (if (eq buffer-undo-list t)
;;       (error "No undo information in this buffer"))
;;   (if (eq last-buffer-undo-list nil)
;;       (error "No undos to redo"))
;;   (or (eq last-buffer-undo-list buffer-undo-list)
;;       ;; skip one undo boundary and all point setting commands up
;;       ;; until the next undo boundary and try again.
;;       (let ((p buffer-undo-list))
;; 	(and (null (car-safe p)) (setq p (cdr-safe p)))
;; 	(while (and p (integerp (car-safe p)))
;; 	  (setq p (cdr-safe p)))
;; 	(eq last-buffer-undo-list p))
;;       (error "Buffer modified since last undo/redo, cannot redo"))
;;   (and (or (eq buffer-undo-list pending-undo-list)
;; 	   (eq (cdr buffer-undo-list) pending-undo-list))
;;        (error "No further undos to redo in this buffer"))
;;   (or (eq (selected-window) (minibuffer-window))
;;       (message "Redo..."))
;;   (let ((modified (buffer-modified-p))
;; 	(undo-in-progress t)
;; 	(recent-save (recent-auto-save-p))
;; 	(old-undo-list buffer-undo-list)
;; 	(p (cdr buffer-undo-list))
;; 	(records-between 0))
;;     ;; count the number of undo records between the head of the
;;     ;; undo chain and the pointer to the next change.  Note that
;;     ;; by `record' we mean clumps of change records, not the
;;     ;; boundary records.  The number of records will always be a
;;     ;; multiple of 2, because an undo moves the pending pointer
;;     ;; forward one record and prepend a record to the head of the
;;     ;; chain.  Thus the separation always increases by two.  When
;;     ;; we decrease it we will decrease it by a multiple of 2
;;     ;; also.
;;     (while p
;;       (cond ((eq p pending-undo-list)
;; 	     (setq p nil))
;; 	    ((null (car p))
;; 	     (setq records-between (1+ records-between))
;; 	     (setq p (cdr p)))
;; 	    (t
;; 	     (setq p (cdr p)))))
;;     ;; we're off by one if pending pointer is nil, because there
;;     ;; was no boundary record in front of it to count.
;;     (and (null pending-undo-list)
;; 	 (setq records-between (1+ records-between)))
;;     ;; don't allow the user to redo more undos than exist.
;;     ;; only half the records between the list head and the pending
;;     ;; pointer are undos that are a part of this command chain.
;;     (setq count (min (/ records-between 2) count)
;; 	  p (primitive-undo (1+ count) buffer-undo-list))
;;     (if (eq p old-undo-list)
;;             nil ;; nothing happened
;;       ;; set buffer-undo-list to the new undo list.  if has been
;;       ;; shortened by `count' records.
;;       (setq buffer-undo-list p)
;;       ;; primitive-undo returns a list without a leading undo
;;       ;; boundary.  add one.
;;       (undo-boundary)
;;       ;; now move the pending pointer backward in the undo list
;;       ;; to reflect the redo.  sure would be nice if this list
;;       ;; were doubly linked, but no... so we have to run down the
;;       ;; list from the head and stop at the right place.
;;       (let ((n (- records-between count)))
;; 	(setq p (cdr old-undo-list))
;; 	(while (and p (> n 0))
;; 	  (if (null (car p))
;; 	      (setq n (1- n)))
;; 	  (setq p (cdr p)))
;; 	(setq pending-undo-list p)))
;;     (and modified (not (buffer-modified-p))
;; 	 (delete-auto-save-file-if-necessary recent-save))
;;     (or (eq (selected-window) (minibuffer-window))
;; 	(message "Redo!"))
;;     (setq last-buffer-undo-list buffer-undo-list)))

;; (defun undo (&optional arg)
;;   "Undo some previous changes.
;; Repeat this command to undo more changes.
;; A numeric argument serves as a repeat count."
;;   (interactive "*p")
;;   (let ((modified (buffer-modified-p))
;; 	(recent-save (recent-auto-save-p)))
;;     (or (eq (selected-window) (minibuffer-window))
;; 	(message "Undo..."))
;;     (or (eq last-buffer-undo-list buffer-undo-list)
;; 	;; skip one undo boundary and all point setting commands up
;; 	;; until the next undo boundary and try again.
;; 	(let ((p buffer-undo-list))
;; 	  (and (null (car-safe p)) (setq p (cdr-safe p)))
;; 	  (while (and p (integerp (car-safe p)))
;; 	    (setq p (cdr-safe p)))
;; 	  (eq last-buffer-undo-list p))
;; 	(progn (undo-start)
;; 	       (undo-more 1)))
;;     (undo-more (or arg 1))
;;     ;; Don't specify a position in the undo record for the undo command.
;;     ;; Instead, undoing this should move point to where the change is.
;;     ;;p
;;     ;;;; The old code for this was mad!  It deleted all set-point
;;     ;;;; references to the position from the whole undo list,
;;     ;;;; instead of just the cells from the beginning to the next
;;     ;;;; undo boundary.  This does what I think the other code
;;     ;;;; meant to do.
;;     (let ((list buffer-undo-list)
;;     	  (prev nil))
;;       (while (and list (not (null (car list))))
;;     	(if (integerp (car list))
;;     	    (if prev
;;     		(setcdr prev (cdr list))
;;     	      ;; impossible now, but maybe not in the future
;;     	      (setq buffer-undo-list (cdr list))))
;;     	(setq prev list
;;     	      list (cdr list))))
;;     (and modified (not (buffer-modified-p))
;; 	 (delete-auto-save-file-if-necessary recent-save)))
;;   (or (eq (selected-window) (minibuffer-window))
;;       (message "Undo!"))
;;   (setq last-buffer-undo-list buffer-undo-list))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(defun my-comment-or-uncomment-region (beg end &optional arg)
  (interactive (if (use-region-p)
                   (list (region-beginning) (region-end) nil)
                 (list (line-beginning-position)
                       (line-beginning-position 2))))
  (comment-or-uncomment-region beg end arg)
  )
(global-set-key [remap comment-or-uncomment-region] 'my-comment-or-uncomment-region)

;;set C indent-style
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
;; (add-hook 'c-mode-hook 'linux-c-mode)
;; (add-hook 'c++-mode-hook 'linux-cpp-mode)
(add-hook 'python-mode-hook (lambda()
                              (setq indent-tabs-mode t)
                              (setq tab-width 8)
                              (set-variable 'python-indent-offset 8)
                              (set-variable 'python-indent-guess-indent-offset nil)
                              ))
(defun linux-c-mode ()
  (define-key c-mode-map [return] 'newline-and-indent)
  (interactive)
  (c-set-style "K&R")
  (c-toggle-hungry-state)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (which-function-mode 1))
  ;; (c-toggle-auto-state)  ;;¹Ø±Õ;×Ô¶¯»»ÐÐ

(defun linux-cpp-mode()
  (define-key c++-mode-map [return] 'newline-and-indent)
  (interactive)
  (c-set-style "stroustrup")
  (c-toggle-hungry-state)
  (setq tab-width 4)
  (setq indent-tabs-mode nil)
  (setq c-basic-offset 4)
  (imenu-add-menubar-index)
  (which-function-mode 1))


;; (global-linum-mode 1)
(global-set-key (kbd "M-,") 'pop-tag-mark)
;; autosave opens file list, next open emacs will open these buffer
;; (desktop-save-mode 1)

;; insert-current-time
(defun insert-current-date ()
    "Insert the current date"
    (interactive "*")
    (insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))
    ;; (insert (format-time-string "%Y/%m/%d" (current-time))))
    (global-set-key "\C-xt" 'insert-current-date)

(defun insert-my-comment-1()
  (interactive)
  (insert (message "// All Rights Reserved.
// Author : zhangfangjie (f22jay@163.com)
// Date %s
// Breif :

" (format-time-string "%Y/%m/%d %H:%M:%S" (current-time)))))


(defun insert-comment-python()
  (interactive)
  (insert (message "################################################################################
#
# All Rights Reserved
#
################################################################################
\"\"\"
Breif:
Authors: zhangfangjie (f22jay@163.com)
Date:    %s
\"\"\"
"  (format-time-string "%Y/%m/%d %H:%M:%S" (current-time)))))

(defun insert-comment-shell()
  (interactive)
  (insert (message "#!/usr/bin/env bash
################################################################################
#
# All Rights Reserved
#
################################################################################
#Breif:
#Authors: zhangfangjie (f22jay@163.com)
#Date:    %s
"  (format-time-string "%Y/%m/%d %H:%M:%S" (current-time)))))

(auto-insert-mode)
(setq auto-insert-query nil)
(define-auto-insert "\\.py" 'insert-comment-python)
(define-auto-insert "\\.\\([Cc]\\|cc\\|cpp\\|h\\)\\'" 'insert-my-comment-1)
(define-auto-insert "\\.sh" 'insert-comment-shell)

(setq multi-shell-command "/bin/bash")
(setq python-shell-interpreter "ipython"
      python-shell-interpreter-args "-i")
;; 在.emacs文件中添加下面这行表示使用拷贝模式
;; (setq backup-by-copying t) ;; 默认是nil，开启之后使用拷贝模式
;; 将~备份文件移到save目录
(setq backup-directory-alist `(("." . "~/.saves")))

;;create shell, and buffer-name is current dir
(defun new-shell ()
  (interactive)
  (let (
        (currentbuf (get-buffer-window (current-buffer)))
        (newbuf  (concat "sh:" default-directory))
        )

    (generate-new-buffer newbuf)
    (set-window-dedicated-p currentbuf nil)
    (set-window-buffer currentbuf newbuf)
    (shell newbuf)
    )
  )

(setq lsp-file-watch-ignored
   (quote
    ("/Users/fangjiezhang" "[/\\\\]\\mod*" "[/\\\\]\\vendor*" "[/\\\\]\\.git$" "[/\\\\]\\.hg$" "[/\\\\]\\.bzr$" "[/\\\\]_darcs$" "[/\\\\]\\.svn$" "[/\\\\]_FOSSIL_$" "[/\\\\]\\.idea$" "[/\\\\]\\.ensime_cache$" "[/\\\\]\\.eunit$" "[/\\\\]node_modules$" "[/\\\\]\\.fslckout$" "[/\\\\]\\.tox$" "[/\\\\]\\.stack-work$" "[/\\\\]\\.bloop$" "[/\\\\]\\.metals$" "[/\\\\]target$" "[/\\\\]\\.ccls-cache$" "[/\\\\]\\.deps$" "[/\\\\]build-aux$" "[/\\\\]autom4te.cache$" "[/\\\\]\\.reference$")))
(setq doom-leader-alt-key "M-m")
(setq flycheck-checker-error-threshold 10)

;;go
(add-hook 'go-mode-hook (lambda()
                          (add-hook 'before-save-hook 'gofmt-before-save)
                          (local-set-key (kbd "C-c C-r") 'go-remove-unused-imports))
          )

;; screenshot

(defun my-org-screenshot ()
  "Take a screenshot into a time stamped unique-named file in the
same directory as the org-buffer and insert a link to this file."
  (interactive)
  (org-display-inline-images)
  (setq filename
        (concat
         (make-temp-name
          (concat (file-name-nondirectory (buffer-file-name))
                  "_imgs/"
                  (format-time-string "%Y%m%d_%H%M%S_")) ) ".png"))
  (unless (file-exists-p (file-name-directory filename))
    (make-directory (file-name-directory filename)))
					; take screenshot
  (if (eq system-type 'darwin)
      (progn
	(call-process-shell-command "screencapture" nil nil nil nil " -s " (concat
									    "\"" filename "\"" ))
	(call-process-shell-command "convert" nil nil nil nil (concat "\"" filename "\" -resize  \"50%\"" ) (concat "\"" filename "\"" ))
	))
  (if (eq system-type 'gnu/linux)
      (call-process "import" nil nil nil filename))
					; insert into file if correctly taken
  (if (file-exists-p filename)
      (insert (concat "[[file:" filename "]]")))
  (org-display-inline-images)
  )

(global-set-key (kbd "C-c s c") 'my-org-screenshot)
(global-set-key (kbd "M-s s ") 'grip-restart-preview)

(defun clear-files ()
  "Remove all existing file notification watches from Emacs."
  (interactive)
  (maphash
   (lambda (key _value)
     (file-notify-rm-watch key))
   file-notify-descriptors))

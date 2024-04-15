;;; keybindings/+keybindings.el -*- lexical-binding: t; -*-

;; Customized key bindings
(map! :leader
      (:prefix "g"
       (:when (featurep! :tools magit)
        :desc "Magit status"               "s"   #'magit-status
        :desc "Magit diff"                 "d"   #'magit-diff
        :desc "Magit blame"                "b"   #'magit-blame-addition
        :desc "Magit buffer log"           "h"   #'magit-log-buffer-file
        :desc "Magit dispatch"             "m"   #'magit-dispatch
        :desc "git link"                   "l"   #'git-link
        :desc "git commit link"            "c"   #'git-link-commit
        )
       )
      (:prefix ("p" . "project")
       :desc "Project shell"   "s" #'projectile-run-shell
       :desc "Project switch"  "p" #'helm-projectile-switch-project
       :desc "Project search file"  "f" #'helm-projectile-find-file
       )

      (:prefix ("c" . "compile")
       :desc "helm-make"   "m" #'+make/run
       ;; :desc "helm-make"   "m" #'helm-make
       :desc "recompile"   "r" #'recompile
       )

      ;; (:prefix ("t" . "major")
      ;;  ;; :desc "test-single"   "s" #'+go/test-single
      ;;  ;; :desc "test-rerun"   "r" #'+go/test-rerun
      ;;  ;; :desc "test-rerun"   "a" #'+go/test-all
      ;;  )

      (:prefix ("s" . "search")
       :desc "search-buffer"   "." #'swiper-isearch-thing-at-point
       )

      ;; (:desc "search-at-point" "." #'+default/search-project-for-symbol-at-point))
      (:desc "search-at-point" "." #'helm-projectile-rg)
      ;; (:desc "search-at-point" "." #'+default/search-project-for-symbol-at-point)
      (:desc "search-at-point" "/" #'helm-projectile-grep)
)

(map! :map org-mode-map
      "M-s RET"    #'org-insert-subheading
      "M-s j" #'org-metadown
      "M-s k" #'org-metaup
      "M-s h" #'org-metaleft
      "M-s l" #'org-metaright
      "M-s i" #'org-toggle-item
      "M-s c" #'org-ctrl-c-minus
      )

;; (general-define-key
;;  :keymaps 'general-override-mode-map
;;  (kbd "M-m t r") nil) ; Unbinds space in general-override-mode-map
;; ;; (define-key rust-mode-map  "M-m t r" nil)

(map! :map general-override-mode-map
      "M-m t r" nil
      "M-m t s" nil
      )


(map! :map go-mode-map
      "M-m l r" #'+go/test-rerun
      "M-m l t" #'+go/test-all
      "M-m l s" #'+go/test-single
      )


(map! :map rust-mode-map
      "M-m l g" #'rustic-cargo-run
      "M-m l b" #'rustic-cargo-build
      "M-m l t" #'rustic-cargo-test
      "M-m l s" #'rustic-cargo-current-test
      "M-m l r" #'rustic-cargo-test-rerun
      "M-m l c" #'rustic-cargo-check
      "M-m l B" #'rustic-cargo-bench
      "M-m l d" #'rustic-cargo-doc
      "M-m l u" #'rustic-cargo-upgrade
      )

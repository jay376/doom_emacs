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
       :desc "helm-make"   "m" #'helm-make
       :desc "recompile"   "r" #'recompile
       )

      (:prefix ("t" . "major")
       :desc "test-single"   "s" #'+go/test-single
       :desc "test-rerun"   "r" #'+go/test-rerun
       :desc "test-rerun"   "a" #'+go/test-all
       )

      (:prefix ("s" . "search")
       :desc "search-buffer"   "." #'swiper-isearch-thing-at-point
       )

      ;; (:desc "search-at-point" "." #'+default/search-project-for-symbol-at-point))
      (:desc "search-at-point" "." #'helm-projectile-rg))

(map! :map org-mode-map
      "M-s RET"    #'org-insert-subheading
      "M-s j" #'org-metadown
      "M-s k" #'org-metaup
      "M-s h" #'org-metaleft
      "M-s l" #'org-metaright
      "M-s i" #'org-toggle-item
      "M-s c" #'org-ctrl-c-minus
      )

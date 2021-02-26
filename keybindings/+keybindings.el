;;; keybindings/+keybindings.el -*- lexical-binding: t; -*-

;; Customized key bindings
(map! :leader
      (:prefix "g"
       (:when (featurep! :tools magit)
        :desc "Magit status"               "s"   #'magit-status
        :desc "Magit diff"                 "d"   #'magit-diff
        :desc "Magit blame"                "b"   #'magit-blame-addition
        :desc "Magit buffer log"           "l"   #'magit-log
        :desc "Magit dispatch"             "m"   #'magit-dispatch
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

      (:desc "search-at-point" "/" #'+default/search-project-for-symbol-at-point)
      )

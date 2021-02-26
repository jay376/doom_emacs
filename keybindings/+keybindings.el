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
       )

      (:desc "search-at-point" "/" #'+default/search-project-for-symbol-at-point)
      )

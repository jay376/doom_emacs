;;; keybindings/+keybindings.el -*- lexical-binding: t; -*-

;; Customized key bindings
(map! :leader
      (:prefix "g"
       (:when (featurep! :tools magit)
        :desc "Magit status"               "s"   #'magit-status
        :desc "Magit blame"                "b"   #'magit-blame-addition
        :desc "Magit fetch"                "f"   #'magit-fetch
        :desc "Magit buffer log"           "l"   #'magit-log
        )
       )
      (:desc "search-at-point" "/" #'+default/search-project-for-symbol-at-point)
      )

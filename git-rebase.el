;; By default emacs enables git-rebase-todo mode where the buffer is read only
;; Therefore `git rebase -i` cannot be used to rewrite history
;; But you can move commits up/down using keyboard
;(setq auto-mode-alist (delete '("git-rebase-todo" . rebase-mode)
                                        ;                              auto-mode-alist))
(add-hook 'git-rebase-todo-mode
          (lambda ()
            (local-set-key (kbd "<M-up") 'git-rebase-move-line-up)
            (local-set-key (kbd "<M-down") 'git-rebase-move-line-down)
            ))

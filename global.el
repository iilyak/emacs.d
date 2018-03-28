(global-linum-mode 1)

(setq transient-mark-mode t)

;(show-trailing-whitespace t)

(add-hook 'before-save-hook 'whitespace-cleanup)

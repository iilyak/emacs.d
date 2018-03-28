(add-hook 'hexl-mode-hook (lambda ()
    (remove-hook 'before-save-hook 'whitespace-cleanup)))

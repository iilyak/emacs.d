(prelude-require-package 'multiple-cursors)

;; disable conflicting keybindings
(defun mc-disable-default-bindings ()
  (let ((oldmap (cdr (assoc 'prelude-mode minor-mode-map-alist)))
        (newmap (make-sparse-keymap)))
    (set-keymap-parent newmap oldmap)
    (define-key newmap [(control shift up)] nil)
    (define-key newmap [(control shift down)] nil)
    (make-local-variable 'minor-mode-overriding-map-alist)
    (push `(prelude-mode . ,newmap) minor-mode-overriding-map-alist))
  )
(add-hook 'prelude-mode-hook 'mc-disable-default-bindings)

;; configure multiple-cursors
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C-S-c C-e") 'mc/edit-ends-of-lines)
(global-set-key (kbd "C-S-c C-a") 'mc/edit-beginnings-of-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-<return>") 'mc/mark-more-like-this-extended)
(global-set-key (kbd "C-S-SPC") 'set-rectangular-region-anchor)
(global-set-key (kbd "C-M-=") 'mc/insert-numbers)
(global-set-key (kbd "C-*") 'mc/mark-all-like-this)
(global-set-key (kbd "C-S-<mouse-1>") 'mc/add-cursor-on-click)
(global-set-key [(control shift up)] 'mc/mark-previous-like-this)
(global-set-key [(control shift down)] 'mc/mark-next-like-this)



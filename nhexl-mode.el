(defun my-nhexl-mode-hook ()
  (when nhexl-mode
    ;; Turn off multibyte, otherwise nhexl 0.1 displays non-ASCII characters
    ;; in hexa as values in the range 3fff80-3fffff instead of 80-ff.
    (if (and (fboundp 'toggle-enable-multibyte-characters)
             enable-multibyte-characters)
        (toggle-enable-multibyte-characters))))
(add-hook 'nhexl-mode-hook 'my-nhexl-mode-hook)

(unless (boundp 'nhexl-mode-map)
  (defvar nhexl-mode-map (make-sparse-keymap)
    "Keymap used when `nhexl-mode' is active."))
(define-key nhexl-mode-map (kbd "C-i") 'binary-overwrite-mode)

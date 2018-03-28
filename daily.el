(defun daily-file ()
  (interactive)
  (let ((daily-name (format-time-string "%Y-%m-%d")))
    (find-file (expand-file-name (concat "~/Documents/Log/" daily-name ".md")))))

(global-set-key (kbd "M-n") 'daily-file)

;; taken from here https://github.com/banjiewen/davisp-indent/blob/master/davisp-indent.el
(setq erlang-indent-level 4)

(defun erlang-outdent ()
  (max 0 (- (current-indentation) erlang-indent-level)))

(defun erlang-indent ()
  (+ (current-indentation) erlang-indent-level))

(defun erlang-indent-line ()
  ;; Watch out, this breaks if you comment your code!
  (indent-line-to
   (save-excursion
     (while (progn
              (forward-line -1)
              (looking-at "^[[:space:]]*$")))
     (end-of-line)
     (cond ((equal (string (char-before)) ",") (current-indentation))
           ((equal (string (char-before)) "(") (erlang-indent))
           ((equal (string (char-before)) "[") (erlang-indent))
           ((equal (string (char-before)) "{") (erlang-indent))
           ((equal (string (char-before)) ".") (erlang-outdent))
           ((equal (string (char-before)) ";") (erlang-outdent))
           ((looking-back "->") (erlang-indent))
           ((looking-back " of") (erlang-indent))
           ;; Default case breaks on `end` statements of case clauses
           (t (erlang-outdent))))))

(defun erlang-indent-region (start end)
  (save-excursion
    (goto-char start)
    (while (progn
             (when (not (looking-at "^[[:space:]]*$"))
               (erlang-indent-line))
             (forward-line)
             (< (line-number-at-pos) (line-number-at-pos end))))))

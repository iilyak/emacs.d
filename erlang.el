(setq erlang-root-dir "~/.kerl/builds/17.5/release_17.5/")
(setq load-path (cons (car (file-expand-wildcards (concat erlang-root-dir "/lib/tools-*/emacs"))) load-path))
(setq erlang-electric-commands nil)

;;;; add include directory to default compile path.
;;(defvar erlang-compile-extra-opts
;;  '(bin_opt_info debug_info
;;                 (i . "../include")
;;                 (i . "../deps")
;;                 (i . "../../")
;;                 (i . "../../../deps")))
;;
;;;; define where put beam files.
;;(setq erlang-compile-outdir "../ebin")

(require 'flymake)

;; add sane indentation
(setq current-dir
  (file-name-directory (file-truename load-file-name)))

(when (file-exists-p (concat current-dir "davisp-indent.el"))
  (load-file (concat current-dir "davisp-indent.el")))


(setq flymake-log-level 3)

;;(defun flymake-create-temp-intemp (file-name prefix)
;;  "Return file name in temporary directory for checking FILE-NAME.
;;This is a replacement for `flymake-create-temp-inplace'. The
;;difference is that it gives a file name in
;;`temporary-file-directory' instead of the same directory as
;;FILE-NAME.
;;For the use of PREFIX see that function.
;;Note that not making the temporary file in another directory
;;\(like here) will not if the file you are checking depends on
;;relative paths to other files \(for the type of checks flymake
;;makes)."
;;  (unless (stringp file-name)
;;    (error "Invalid file-name"))
;;  (or prefix
;;      (setq prefix "flymake"))
;;  (let* ((name (concat
;;                (file-name-nondirectory
;;                 (file-name-sans-extension file-name))
;;                "_" prefix))
;;         (ext (concat "." (file-name-extension file-name)))
;;         (temp-name (make-temp-file name nil ext))
;;         )
;;    (flymake-log 3 "create-temp-intemp: file=%s temp=%s" file-name temp-name)
;;    temp-name))
;;
;;(defun get-erlang-app-dir ()
;;  (let* ((src-path (file-name-directory (buffer-file-name)))
;;         (pos (string-match "/src/" src-path)))
;;    (if pos
;;        (substring src-path 0 (+ 1 pos))
;;      src-path)))
;;
;;(setq erlang-flymake-get-code-include-dirs-function
;;      (lambda ()
;;        (concat (get-erlang-app-dir) "include")))
;;
;;(setq erlang-flymake-get-code-path-dirs-function
;;      (lambda ()
;;        (concat (get-erlang-app-dir) "ebin")))
;;
(defun flymake-compile-script-path (path)
  ;;  (let* ((temp-file (flymake-init-create-temp-buffer-copy
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list path (list (find-root) buffer-file-name))))
    ;;(list path (list local-file))))

(defun find-root ()
  (locate-dominating-file (file-name-directory buffer-file-name)
                          (lambda (parent) (directory-files parent nil "rel"))))

(defun flymake-syntaxerl ()
   (flymake-compile-script-path "~/.emacs.d/personal/bin/syntaxerl"))

;;(add-hook 'erlang-mode-hook
;;  '(lambda()
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.erl\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.hrl\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.app\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.app.src\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.config\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.rel\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.script\\'" flymake-syntaxerl))
;;     (add-to-list 'flymake-allowed-file-name-masks '("\\.escript\\'" flymake-syntaxerl))
;;
;;     ;; should be the last.
;;     ;; (flymake-mode 1)
;;))

(defun erlang-flymake-only-on-save ()
  "Trigger flymake only when the buffer is saved (disables syntax
check on newline and when there are no changes)."
  (interactive)
  ;; There doesn't seem to be a way of disabling this; set to the
  ;; largest int available as a workaround (most-positive-fixnum
  ;; equates to 8.5 years on my machine, so it ought to be enough ;-) )
  (setq flymake-no-changes-timeout most-positive-fixnum)
  (setq flymake-start-syntax-check-on-newline nil))

(erlang-flymake-only-on-save)

(defun erlang-doc ()
  (interactive)
  (setq-local helm-dash-docsets '("Erlang")))

(add-hook 'erlang-mode-hook 'erlang-doc)

;;(tempo-define-template
;; "erlang-eunit-tests"
;; '((p name)"_test_() ->" n
;;   > "{" n
;;   > "\""(p description)"\"," n
;;   >> "{"
;;   >>> "foreach," n
;;   >>> "fun setup/0, fun teardown/1," n
;;   >>> "[" n r p
;;   >>> "]"
;;   >> "}"
;;   > "}." n
;;   ))

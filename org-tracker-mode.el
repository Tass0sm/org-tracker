(defvar org-tracker-map
  (let ((map (make-keymap)))
    (define-key map "\C-c\C-e" 'test-function)
  ;;(define-key map (kbd "<return>") 'complete-problem)
  ;;(define-key map "\C-c\C-r" 'set-operand-limit)
  ;;(define-key map flyspell-auto-correct-binding 'flyspell-auto-correct-previous-word)
  ;;(define-key map [(control ?\,)] 'flyspell-goto-next-error)
  ;;(define-key map [(control ?\.)] 'flyspell-auto-correct-word)
  ;;(define-key map [?\C-c ?$] 'flyspell-correct-word-before-point)
    map)
  "Minor mode keymap for org-tracker.")

(defun test-function ()
  "Test Function"
  (interactive)
  (message "Test Message"))

(define-minor-mode org-tracker-mode
  "Toggle data tracker for entering data to remember.  With a
   prefix argument ARG, enable org-tracker-mode if ARG is
   positive, and disable it otherwise.  If called from Lisp,
   enable the mode if ARG is omitted or nil.

   org-tracker-mode is a buffer-local minor mode. When enabled,
   data can be quickly entered for a given day. Works well in the
   org-agenda view."
  :lighter " tracker"
  :keymap org-tracker-map
  (if org-tracker-mode
      (condition-case err
	  ;;body
	  (org-tracker-mode-on)
	;;error handler
	(error (message "Error enabling Flyspell mode:\n%s" (cdr err))
	       (flyspell-mode -1)))
    (org-tracker-mode-off)))

(defun turn-on-tracker ()
  "Unconditionally turn on org-tracker-mode."
  (org-tracker-mode 1))

(defun turn-off-tracker ()
  "Unconditionally turn off org-tracker-mode."
  (org-tracker-mode -1))

(defun org-tracker-mode-off ()
  "Turn org-tracker-mode off."
  ;; We mark the mode as killed.
  (setq org-tracker-mode nil))

(defun org-tracker-mode-on ()
  "Turn org-tracker-mode on. Do not use this; use `org-tracker-mode' instead."
  )

(provide 'org-tracker-mode)

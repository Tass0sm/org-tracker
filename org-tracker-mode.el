(defgroup tracker nil
  "Org Tracker minor mode for logging daily data."
  :tag "Org Tracker"
  :prefix "org-tracker-"
  :group 'org)

(defcustom org-tracker-history-file nil
  "Location of file for tracked history table."
  :tag "History File"
  :type 'file
  :group 'tracker)

(defun track-in-file ()
  "Test Function. Writes in customizable variable
tracker-history-file."
  (interactive)
  (append-to-file "Test Message" nil org-tracker-history-file)
  (message "Test Message"))

(defun org-tracker-day-on-line ()
  "Get date "
  (interactive)
  (let* ((date-string (buffer-substring (point-at-bol) (point-marker)))
	 (date-value (condition-case err
			 (date-to-time date-string)
		       (error (message "ahhh")))))
    (message date-string)))

(parse-time-string "  projects:   Deadline:   Finish Chapter 5")

;; (message (format "%s" date-value))))

(defun org-tracker-track-day ()
  ""
  (interactive)
  (let ((col (current-column))
	 (marker (or (org-get-at-bol 'org-marker)
		     (org-agenda-error)))
	 (buffer (marker-buffer marker))
	 (pos (marker-position marker))
	 (hdmarker (org-get-at-bol 'org-hd-marker))
	 (todayp (org-agenda-today-p (org-get-at-bol 'day)))
	 (inhibit-read-only t)
	 org-agenda-headline-snapshot-before-repeat newhead just-one)
    ())

(defvar org-tracker-map
  (let ((map (make-keymap)))
    (define-key map "\C-c\C-e" 'track-in-file)
  ;;(define-key map (kbd "<return>") 'complete-problem)
  ;;(define-key map "\C-c\C-r" 'set-operand-limit)
  ;;(define-key map flyspell-auto-correct-binding 'flyspell-auto-correct-previous-word)
  ;;(define-key map [(control ?\,)] 'flyspell-goto-next-error)
  ;;(define-key map [(control ?\.)] 'flyspell-auto-correct-word)
  ;;(define-key map [?\C-c ?$] 'flyspell-correct-word-before-point)
    map)
  "Minor mode keymap for org-tracker.")

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
	(error (message "Error enabling org-tracker-mode:\n%s" (cdr err))
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

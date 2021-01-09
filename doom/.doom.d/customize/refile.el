(defun +org/opened-buffer-files ()
  "Return the list of files currently opened in emacs"
  (delq nil
    (mapcar (lambda (x)
      (if (and (buffer-file-name x)
       (string-match "\\.org$"
             (buffer-file-name x)))
    (buffer-file-name x)))
    (buffer-list))))

(setq org-refile-targets '((+org/opened-buffer-files :maxlevel . 9)))


(setq org-refile-use-outline-path 'file)
;; makes org-refile outline working with helm/ivy
(setq org-outline-path-complete-in-steps nil)
(setq org-refile-allow-creating-parent-nodes 'confirm)

(defun +org-search ()
  (interactive)
  (org-refile '(4)))


(setq org-refile-use-cache t)

(run-with-idle-timer 15 t (lambda ()
    (org-refile-cache-clear)
    (org-refile-get-targets)))

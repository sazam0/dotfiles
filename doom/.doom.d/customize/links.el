;; https://koenig-haunstetten.de/2016/07/09/code-snippet-for-orgmode-e05s02/

(defun my-generate-id-all-first-level()
"generate(if not exists) or copy(if exists) ID on top level entries
using 'my-id-get-or-generate' function.

This function works only in org-mode buffers.

The purpose of this function is to easily construct id:-links to
org-mode items. If its assigned to a key it saves you marking the
text and copying to the killring."
       (interactive)
       (when (eq major-mode 'org-mode) ; do this only in org-mode buffers
	 ;; (setq mytmpid (funcall 'org-id-get-create))
   (org-map-entries 'my-id-get-or-generate "LEVEL=1")
	 ;; (kill-new mytmpid)
	 ;; (message "Copied %s to killring (clipboard)" mytmpid)
       ))

;; modified=> source : https://karl-voit.at/2019/11/16/UOMF-Linking-Headings/
 (defun my-id-get-or-generate()
 "Returns the ID property if set or generates and returns a new one if not set.
  The generated ID is timestamp__headline."
     (interactive)
       (when (not (org-id-get))
       (progn
          (let* (
            (my-heading-text (nth 4 (org-heading-components)))
            (my-heading-text (my-generate-sanitized-alnum-dash-string my-heading-text))
            )
         (setq new-id (concat (format-time-string "%d-%b-%Y_%H:%M:%S:%3N__") my-heading-text))
            (org-set-property "ID" new-id)
          	 (message "New ID %s is set" new-id)
           )
         )
         )
 	(kill-new (org-id-get));; put ID in kill-ring
 (message "Copied %s to killring (clipboard)" (org-id-get))
 	;; (org-id-get);; retrieve the current ID in any case as return value
 )


(defun my-generate-sanitized-alnum-dash-string(str)
"Returns a string which contains only a-zA-Z0-9 with single dashes
replacing all other characters in-between them.

Some parts were copied and adapted from org-hugo-slug
from https://github.com/kaushalmodi/ox-hugo (GPLv3)."
;; (message "id :: %s" str)
(let* (;; Remove "<FOO>..</FOO>" HTML tags if present.
      (str (replace-regexp-in-string "<\\(?1:[a-z]+\\)[^>]*>.*</\\1>" "" str))
      ;; Remove URLs if present in the string.  The ")" in the
      ;; below regexp is the closing parenthesis of a Markdown
      ;; link: [Desc](Link).
      (str (replace-regexp-in-string (concat "\\](" ffap-url-regexp "[^)]+)") "]" str))
      ;; Remove URLs for orgmode: [[link]], or [[link][description]]
      (str (replace-regexp-in-string "\\[\\[" "!!" str))
      (str (replace-regexp-in-string "\\]\\]" "!!" str))
      (str (replace-regexp-in-string "\\]\\[" "!?!" str))
      ;; Replace "&" with " and ", "." with " dot ", "+" with
      ;; " plus ".
      ;; (str (replace-regexp-in-string
      ;;       "&" " and "
      ;;       (replace-regexp-in-string
      ;;        "\\." " dot "
      ;;        (replace-regexp-in-string
      ;;         "\\+" " plus " str))))
      ;; Replace German Umlauts with 7-bit ASCII.
      ;; (str (replace-regexp-in-string "[Ä]" "Ae" str t))
      ;; (str (replace-regexp-in-string "[Ü]" "Ue" str t))
      ;; (str (replace-regexp-in-string "[Ö]" "Oe" str t))
      ;; (str (replace-regexp-in-string "[ä]" "ae" str t))
      ;; (str (replace-regexp-in-string "[ü]" "ue" str t))
      ;; (str (replace-regexp-in-string "[ö]" "oe" str t))
      ;; (str (replace-regexp-in-string "[ß]" "ss" str t))
      ;; Replace all characters except alphabets, numbers and
      ;; parentheses with spaces.
      ;; (str (replace-regexp-in-string "[^[:alnum:]()]" " " str))
      ;; On emacs 24.5, multibyte punctuation characters like "："
      ;; are considered as alphanumeric characters! Below evals to
      ;; non-nil on emacs 24.5:
      ;;   (string-match-p "[[:alnum:]]+" "：")
      ;; So replace them with space manually..
      ;; (str (if (version< emacs-version "25.0")
      ;;          (let ((multibyte-punctuations-str "：")) ;String of multibyte punctuation chars
      ;;            (replace-regexp-in-string (format "[%s]" multibyte-punctuations-str) " " str))
      ;;        str))
      ;; Remove leading and trailing whitespace.
      (str (replace-regexp-in-string "\\(^[[:space:]]*\\|[[:space:]]*$\\)" "" str))
      ;; Replace 2 or more spaces with a single space.
      (str (replace-regexp-in-string "[[:space:]]\\{2,\\}" " " str))
      ;; ;; Replace parentheses with double-hyphens.
      ;; (str (replace-regexp-in-string "\\s-*([[:space:]]*\\([^)]+?\\)[[:space:]]*)\\s-*" " -\\1- " str))
      ;; ;; Remove any remaining parentheses character.
      ;; (str (replace-regexp-in-string "[()]" "" str))
      ;; Replace spaces with hyphens.
      (str (replace-regexp-in-string " " "-" str))
      ;; ;; Remove leading and trailing hyphens.
      ;; (str (replace-regexp-in-string "\\(^[-]*\\|[-]*$\\)" "" str))
      )
 str)
)

;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
(setq user-full-name "sazam"
      user-mail-address "azamtariful0@gmail.com")

(setq-default
 delete-by-moving-to-trash t                      ; Delete files to trash
 tab-width 4                                                         ; Set width for tabs
 uniquify-buffer-name-style 'forward      ; Uniquify buffer names
 window-combination-resize t                    ; take new window space from all other windows (not just current)
 x-stretch-cursor t)                                           ; Stretch cursor to the glyph width

(set-frame-name "emacs")

(setq undo-limit 80000000                          ; Raise undo-limit to 80Mb
      evil-want-fine-undo t                             ; By default while in insert all changes are one big blob. Be more granular
      auto-save-default t                                    ; Nobody likes to loose work, I certainly don't
      inhibit-compacting-font-caches t      ; When there are lots of glyphs, keep them in memory
      truncate-string-ellipsis "…")               ; Unicode ellispis are nicer than "...", and also save /precious/ space

(delete-selection-mode 1)                             ; Replace selection when inserting text
(display-time-mode 1)                                   ; Enable time in the mode-line
(global-subword-mode 1)                           ; Iterate through CamelCase words
(setq line-spacing 0.3)                                   ; seems like a nice line spacing balance.

(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))                           ; On laptops it's nice to know how much power you have

(if (eq initial-window-system 'x)                 ; if started by emacs command or desktop file
    (toggle-frame-maximized)
  (toggle-frame-fullscreen))

(setq evil-vsplit-window-right t
      evil-split-window-below t)
(defadvice! prompt-for-buffer (&rest _)
  :after '(evil-window-split evil-window-vsplit)
  (+ivy/switch-buffer))
(setq +ivy-buffer-preview t)

(defun doom-modeline-conditional-buffer-encoding ()
  (setq-local doom-modeline-buffer-encoding
              (unless (or (eq buffer-file-coding-system 'utf-8-unix)
                          (eq buffer-file-coding-system 'utf-8)))))
(add-hook 'after-change-major-mode-hook #'doom-modeline-conditional-buffer-encoding)

(map! :map evil-window-map
      "SPC" #'rotate-layout
      "<left>"     #'evil-window-left
       "<down>"     #'evil-window-down
       "<up>"       #'evil-window-up
       "<right>"    #'evil-window-right
       ;; Swapping windows
       "C-<left>"       #'+evil/window-move-left
       "C-<down>"       #'+evil/window-move-down
       "C-<up>"         #'+evil/window-move-up
       "C-<right>"      #'+evil/window-move-right)

(setq frame-title-format
    '(""
      (:eval
       (if (s-contains-p org-roam-directory (or buffer-file-name ""))
           (replace-regexp-in-string ".*/[0-9]*-?" "🢔 " buffer-file-name)
         "%b"))
      (:eval
       (let ((project-name (projectile-project-name)))
         (unless (string= "-" project-name)
           (format (if (buffer-modified-p)  " ◉ %s" "  ●  %s") project-name))))))

;;light themes
;(setq doom-theme 'doom-gruvbox-light)
;(setq doom-theme 'zaiste)
(setq doom-theme 'doom-flatwhite)
;;dark themes
;;(setq doom-theme 'doom-palenight)

(setq display-line-numbers-type 'relative)

 (defun my-buffer-face-mode-variable ()
   "Set font to a variable width (proportional) fonts in current buffer"
   (interactive)
;   (setq buffer-face-mode-face '(:family "Menlo" :height 95 ))
   (buffer-face-mode))
 (add-hook 'org-mode-hook 'my-buffer-face-mode-variable)

(setq org-directory "~/Nextcloud/org/")

(use-package! org-ref
    :after org
    :init
    ; code to run before loading org-ref
    :config
    ; code to run after loading org-ref
    )
(setq org-ref-notes-directory "~/Nextcloud/org/roamDir"
      org-ref-bibliography-notes "~/Nextcloud/org/articles.org" ;; not needed anymore. Notes now taken in org-roaM
      org-ref-default-bibliography '("~/Nextcloud/org/bibRepo/GaN-highpower.bib")
      org-ref-pdf-directory "~/Nextcloud/literature/"
      org-ref-completion-library 'org-ref-ivy-cite
      org-ref-get-pdf-filename-function 'org-ref-get-pdf-filename-helm-bibtex)

;; (after! org
;;   (add-to-list 'org-capture-templates
;;                '(("a"               ; key
;;                   "Article"         ; name
;;                   entry             ; type
;;                   (file+headline "~/Nextcloud/org/phd.org" "Article")  ; target
;;                   "\* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %U\n:Linked: %a\n:END:\n%i\nBrief description:\n%?"  ; template
;;
;;                   :prepend t        ; properties
;;                   :empty-lines 1    ; properties
;;                   :created t        ; properties
;; ))) )

(use-package! helm-bibtex
  :after org
  :init
  ; blah blah
  :config
  ;blah blah
  )

(setq bibtex-format-citation-functions
      '((org-mode . (lambda (x) (insert (concat
                                         "\\cite{"
                                         (mapconcat 'identity x ",")
                                         "}")) ""))))
(setq
      bibtex-completion-pdf-field "file"
      bibtex-completion-bibliography
      '("~/Nextcloud/org/bibRepo/GaN-highpower.bib")
      bibtex-completion-library-path '("~/Nextcloud/literature/")
      bibtex-completion-notes-path "~/Nextcloud/org/articles.org"  ;; not needed anymore as I take notes in org-roam
      )

(use-package! zotxt
  :after org)
;(add-to-list 'load-path (expand-file-name "ox-pandoc" starter-kit-dir))

(use-package! ox-pandoc
  :after org)
;; default options for all output formats
(setq org-pandoc-options '((standalone . _)))
;; cancel above settings only for 'docx' format
(setq org-pandoc-options-for-docx '((standalone . nil)))
;; special settings for beamer-pdf and latex-pdf exporters
(setq org-pandoc-options-for-beamer-pdf '((pdf-engine . "xelatex")))
(setq org-pandoc-options-for-latex-pdf '((pdf-engine . "pdflatex")))
;; special extensions for markdown_github output
(setq org-pandoc-format-extensions '(markdown_github+pipe_tables+raw_html))

(use-package! org-roam-bibtex
  :load-path "~/Nextcloud/org/bibRepo/GaN-highpower.bib" ;Modify with your own path
  :hook (org-roam-mode . org-roam-bibtex-mode)
  :bind (:map org-mode-map
         (("C-c n a" . orb-note-actions))))

 (setq orb-preformat-keywords   '(("citekey" . "=key=") "title" "url" "file" "author-or-editor" "keywords"))

(setq orb-templates
      '(("r" "ref" plain (function org-roam-capture--get-point) ""
         :file-name "${citekey}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n" ; <--
         :unnarrowed t)
        ("n" "ref+noter" plain (function org-roam-capture--get-point)
         ""
         :file-name "${slug}"
         :head "#+TITLE: ${citekey}: ${title}\n#+ROAM_KEY: ${ref}\n#+ROAM_TAGS:

- tags ::
- keywords :: ${keywords}
\* ${title}
:PROPERTIES:
:Custom_ID: ${citekey}
:URL: ${url}
:AUTHOR: ${author-or-editor}
:NOTER_DOCUMENT: %(orb-process-file-field \"${citekey}\")
:NOTER_PAGE:
:END:")))

; org-roam settings
(setq org-roam-directory "~/Nextcloud/org/roamDir")
(after! org-roam
        (map! :leader
            :prefix "n"
            :desc "org-roam" "l" #'org-roam
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-switch-to-buffer" "b" #'org-roam-switch-to-buffer
            :desc "org-roam-find-file" "f" #'org-roam-find-file
            :desc "org-roam-show-graph" "g" #'org-roam-show-graph
            :desc "org-roam-insert" "i" #'org-roam-insert
            :desc "org-roam-capture" "c" #'org-roam-capture))
            ;; :desc "org-roam-store-link" "I" #'org-roam-store-link))

; from orginial file
;; (use-package! org-roam-protocol
;;   :after org-protocol)

;; org-drill
;; configuration from: https://www.youtube.com/watch?v=uraPXeLfWcM
;;
(use-package org-drill
  :config
  (setq org-drill-hint-separator "||")
  (setq org-drill-left-cloze-delimiter "<[")
  (setq org-drill-right-cloze-delimiter "]>")
  (setq org-drill-learn-fraction 0.25)
  )
;; org-journal the DOOM way
(use-package org-journal
  :init
  (setq org-journal-dir "~/Nextcloud/org/Daily/"
        org-journal-date-prefix "#+TITLE: "
        org-journal-file-format "%Y-%m-%d.org"
        org-journal-date-format "%A, %d %B %Y")
  :config
  (setq org-journal-find-file #'find-file-other-window )
  (map! :map org-journal-mode-map
        "C-c n s" #'evil-save-modified-and-close )

  (defun org-journal-find-location ()
   ;; Open today's journal, but specify a non-nil prefix argument in order to
   ;; inhibit inserting the heading; org-capture will insert the heading.
   (org-journal-new-entry t)
   ;; Position point on the journal's top-level heading so that org-capture
   ;; will add the new entry as a child entry.
   (goto-char (point-min)))
  )

(setq org-journal-enable-agenda-integration t)

(use-package deft
      :after org
      :bind
      ("C-c n d" . deft)
      :custom
      (deft-recursive t)
      (deft-use-filter-string-for-filename t)
      (deft-default-extension "org")
      (deft-directory "~/Nextcloud/org/roamDir/"))

(use-package! org-roam-server
  :after org-roam
  :config
  (setq org-roam-server-host "127.0.0.1"
        org-roam-server-port 8080
        org-roam-server-export-inline-images t
        org-roam-server-authenticate nil
        org-roam-server-label-truncate t
        org-roam-server-label-truncate-length 60
        org-roam-server-label-wrap-length 20)
  (defun org-roam-server-open ()
    "Ensure the server is active, then open the roam graph."
    (interactive)
    (org-roam-server-mode 1)
    (browse-url-xdg-open (format "http://localhost:%d" org-roam-server-port))))
(after! org-roam
  (org-roam-server-mode))

(use-package! org-download
  :after org
  :bind
  (:map org-mode-map
        (("s-Y" . org-download-screenshot)
         ("s-y" . org-download-yank))))

;(after! centaur-tabs
 ; (centaur-tabs-mode -1)
  ;(setq centaur-tabs-height 36
   ;     centaur-tabs-set-icons t
    ;    centaur-tabs-modified-marker "o"
     ;   centaur-tabs-close-button "×"
      ;  centaur-tabs-set-bar 'above)
       ; centaur-tabs-gray-out-icons 'buffer
  ;(centaur-tabs-change-fonts "P22 Underground Book" 160))
;; (setq x-underline-at-descent-line t)

 (use-package! org-fancy-priorities
; :ensure t
  :hook
  (org-mode . org-fancy-priorities-mode)
  :config
   (setq org-fancy-priorities-list '("⚡" "⬆" "⬇" "☕")))

(use-package! org-super-agenda
  :commands (org-super-agenda-mode))
(after! org-agenda
  (org-super-agenda-mode))

(setq org-agenda-skip-scheduled-if-done t
      org-agenda-skip-deadline-if-done t
      org-agenda-include-deadlines t
      org-agenda-block-separator nil
      org-agenda-tags-column 100 ;; from testing this seems to be a good value
      org-agenda-compact-blocks t)
(setq org-agenda-files "~/Nextcloud/org/Daily/")
(load! "./agenda-commands")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-journal-date-format "%A, %d %B %Y" t)
 '(org-journal-date-prefix "#+TITLE: " t)
 '(org-journal-dir "~/Nextcloud/org/Daily/" t)
 '(org-journal-file-format "%Y-%m-%d.org" t)
 '(package-selected-packages (quote (org-fancy-priorities))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; adding custom key-bindings for most used functions
(map! :leader "f a"#'helm-bibtex)  ; "find article" : opens up helm bibtex for search.
(map! :leader "o n"#'org-noter)    ; "org noter"  : opens up org noter in a headline
(map! :leader "r c i"#'org-clock-in); "routine clock in" : clock in to a habit.
(map! :leader "c b"#'beacon-blink) ; "cursor blink" : makes the beacon-blink

(use-package! org
  :config
  (setq
  ; org-bullets-bullet-list '("⁖")
   org-todo-keyword-faces
   '(("TODO" :foreground "#7c7c75" :weight normal :underline t)
     ("WAITING" :foreground "#9f7efe" :weight normal :underline t)
     ("INPROGRESS" :foreground "#0098dd" :weight normal :underline t)
     ("DONE" :foreground "#50a14f" :weight normal :underline t)
     ("CANCELLED" :foreground "#ff6480" :weight normal :underline t))
   org-priority-faces '((65 :foreground "#e45649")
                        (66 :foreground "#da8548")
                        (67 :foreground "#0098dd"))
   ))

(after! company
  (setq company-idle-delay 0.5
        company-minimum-prefix-length 2)
  (setq company-show-numbers t)
(add-hook 'evil-normal-state-entry-hook #'company-abort)) ;; make aborting less annoying.

(setq-default history-length 1000) ; remembering history from precedent
(setq-default prescient-history-length 1000)

(use-package! info-colors
  :commands (info-colors-fontify-node))

(add-hook 'Info-selection-hook 'info-colors-fontify-node)

(add-hook 'Info-mode-hook #'mixed-pitch-mode)

(org-add-link-type "mpv" (lambda (path) (browse-url-xdg-open path)))
(org-add-link-type "img" (lambda (path) (browse-url-xdg-open path)))

(load! "./customize/org-templates")
(load! "./customize/anki-notes")
(load! "./customize/refile")
(load! "./customize/links")


;; (global-set-key (kbd "F10") 'my-copy-id-to-clipboard)
;; (global-set-key (kbd "F9") 'my-id-get-or-generate)

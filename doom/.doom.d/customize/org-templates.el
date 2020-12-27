;; used keys:
;; a: anki notes (in anki-notes.el file)
;; e: exclusive
;; h: hdl
;; k: keyboard bindings
;; m: mail
;; n: ref+noter
;; p: programming
;; r: ref
;; s: todo(schedule)
;; t: org-roam
;; u: recent buffers
;; v: new note
;; x: daily notes
;; y: youtube
;; z: opened buffers

(after! org-roam
   (setq org-roam-capture-ref-templates
     '(("t" "ref" plain (function org-roam-capture--get-point)
        :file-name "../web/${slug}"
        :head "#+TITLE: ${title} \n#+ROAM_KEY: ${ref} \n#+DATE: %U \n#+URL: ${ref} \n\n\n${body}"
        "%?"
        :unnarrowed t))))  ; capture template to grab websites. Requires org-roam protocol.

(defun org-opened-buffers ()
  "choose file from opened buffers to be used in org-capture"
  ;; (helm-recentf)
  (+helm/workspace-buffer-list)
  (goto-char (point-max))
  )


(defun org-recent-buffers ()
  "chose file from recent history to be used in org-capture"
  (helm-recentf)
  ;; (+helm/workspace-buffer-list)
  (goto-char (point-max))
  )

(defun find-blog-post-for-capture ()
    "Find and create new file in the directory to be used in org-capture"
    (interactive)
    (ido-find-file-in-dir "~/Dropbox/Org/"))

;; Capture Templates for TODO tasks
(setq org-capture-templates
    '(
      ;;
      ;; programming
      ;;
      ("p" "programming")

    ;; python programming
   ("pa" "python programming" entry (file "~/Dropbox/Org/ppy.org")
    "* %^{Question}\n#+Created: %T\n\n#+BEGIN_SRC python\n %?\n\n#+END_SRC\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; python bookmark
   ("pb" "python bookmark" entry (file "~/Dropbox/Org/ppy.org")
   "* %a \n%T\n#+tags: %^{tag|numpy|pandas|matlplotlib|tensorflow|pytorch}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; javascript programming
   ("pc" "javascript programming" entry (file "~/Dropbox/Org/pjs.org")
    "* %^{Question}\n#+Created: %T\n\n#+BEGIN_SRC js\n %?\n\n#+END_SRC\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; javascript bookmark
   ("pd" "javascript bookmark" entry (file "~/Dropbox/Org/pjs.org")
   "* %a \n#+created: %T\n#+tags: %^{tag|react|chrome extension|solid js}\n#+comment: %?\n%i"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; c programming
   ("pe" "c programming" entry (file "~/Dropbox/Org/pc.org")
    "* %^{Question}\n#+Created: %T\n\n#+BEGIN_SRC c\n %?\n\n#+END_SRC\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;; c bookmark
   ("pf" "c bookmark" entry (file "~/Dropbox/Org/pc.org")
   "* %a \n%T\n#+tags: %^{tag}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; c++ programming
   ("pg" "c++ programming" entry (file "~/Dropbox/Org/pcc.org")
    "* %^{Question}\n#+Created: %T\n\n#+BEGIN_SRC c++\n %?\n\n#+END_SRC\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;; c++ bookmark
   ("ph" "c++ bookmark" entry (file "~/Dropbox/Org/pcc.org")
   "* %a \n%T\n#+tags: %^{tag}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

  ;; elisp programming
   ("pi" "elisp programming" entry (file "~/Dropbox/Org/pElisp.org")
    "* %^{Question}\n#+Created: %T\n\n#+BEGIN_SRC elisp\n %?\n\n#+END_SRC\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;; elisp  bookmark
   ("pj" "elisp bookmark" entry (file "~/Dropbox/Org/pElisp.org")
   "* %a \n%T\n#+tags: %^{tag}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;;
     ;; hdl programming
     ;;
      ("h" "hdl programming")

    ;; vhdl programming
   ("ha" "vhdl programming" entry (file "~/Dropbox/Org/vhdl.org")
    "* %^{Question}\n#+Created: %T\n#+tags: %^{tag|design|testbench|assertion}\n\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; vhdl bookmark
   ("hb" "vhdl bookmark" entry (file "~/Dropbox/Org/vhdl.org")
    "* %a \n%T\n#+tags: %^{tag|design|testbench|assertion}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; verilog programming
   ("hc" "verilog programming" entry (file "~/Dropbox/Org/verilog.org")
    "* %^{Question}\n#+Created: %T\n#+tags: %^{tag|design|testbench|assertion}\n\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; verilog bookmark
   ("hd" "verilog bookmark" entry (file "~/Dropbox/Org/verilog.org")
    "* %a \n%T\n#+tags: %^{tag|design|testbench|assertion}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; systemVerilog  programming
   ("he" "system verilog programming" entry (file "~/Dropbox/Org/sysVerilog.org")
    "* %^{Question}\n#+Created: %T\n#+tags: %^{tag|design|testbench|assertion}\n\n#+Explanation: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;; systemVerilog bookmark
   ("hf" "system verilog bookmark" entry (file "~/Dropbox/Org/sysVerilog.org")
   "* %a \n%T\n#+tags: %^{tag|design|testbench|assertion}\n#+description: %i\n#+comment: %?"
    :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;;
    ;; youtube
    ;;
      ("y" "youtube")

    ;; university lectures bookmark
   ("ya" "university lectures" entry (file "~/Dropbox/Org/yLectures.org")
    "* %a \n%T\n#+subject: %^{subject|digital|analog|learning|physics}\n#+course: %^{course}\t\t\t\tyear: %^{year}\n#+professor: %^{professor}\n#+university: %^{university}\n#+description: %i\n#+comment: %?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)
    ;; "* %a \n%T\n#+category: %^{tag}\n %i"

   ;; youtube tutorial bookmark
   ("yb" "youtube tutorial" entry (file "~/Dropbox/Org/yTutorial.org")
     "* %a \n%T\n#+category: %^{category|application setup|ubuntu|productivity|note taking|accessories}\n#+description: %i\n#+comment: %? "
   :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; summer school and workshops bookmark
   ("yc" "summer schools and workshops" entry (file "~/Dropbox/Org/ySummerSchools_Workshops.org")
    "* %a \n%T\n#+subject area:%^{subject area|reinforcement|bayesian/gaussian|auto encodere|dft simulation|physics}\nyear: %^{year}\n#+place: %^{place}\n#+person: %^{person}\n#+description: %i\n#+comment: %?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;;
    ;; mail
   ;;
       ("m" "mail")

     ;; university admin bookmark
    ("ma" "university admin" entry (file "~/Dropbox/Org/mailUniAdmin.org")
     "* %a \n%T\n#+subject: %^{subject}\n#+description: %i\n#+comment: %?\n** TODO: ?"
      :empty-lines 1
      :prepend t
      :unnarrowed t)

    ;; university admin bookmark(timeline)
   ("mb" "university admin (timeline)" entry (file "~/Dropbox/Org/mailUniAdmin.org")
    "* %a \n%T\n#+subject: %^{subject}\n#+description: %i\n#+deadline: %^t\n#+comment: %?\n** TODO: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

   ;; scholar literature bookmark
   ("mc" "scholar literature" entry (file "~/Dropbox/Org/gScholar.org")
     "* %a \n%T\n#+subject area:%^{subject area|learning|digital|memory|neuro computing|FET}\n#+specified area: %^{specified area}\n#+title: %^{title}\n#+authors: %^{authors}\n#+keywords: %^{keywords}\n#+research group (prof.): %^{research group (prof.)|onor mutlu|wehn|hesameddin|biswajit debnath}\n#+description: %i\n#+comment: %? "
   :empty-lines 1
     :prepend t
     :unnarrowed t)

    ;; professional bookmark
   ("md" "professional" entry (file "~/Dropbox/Org/mailProfessional.org")
    "* %a \n%T\n#+subject:%^{subject}\n#+description: %i\n#+year: %?\n#+comment: %?\n** TODO: ?"
     :empty-lines 1
     :prepend t
     :unnarrowed t)

     ;; tanvir hasan bookmark
    ("me" "mail from tanvir hasan" entry (file "~/Dropbox/Org/mailTanvir.org")
     "* %a \n%T\n#+subject:%^{subject}\n#+description: %i\n#+comment: ?"
      :empty-lines 1
      :prepend t
      :unnarrowed t)

      ;;
      ;; exclusive
      ;;
         ("e" "exclusive")

      ;; health guideline
     ("ea" "health guidline" entry (file "~/Dropbox/Org/exclusive/hGuideline.org")
      "* %a \n%T\n#+tag: %^{tag|nutrition|yoga|workouts}\n#+description: %i\n#+comment: %?\n** TODO: ?"
       :empty-lines 1
       :prepend t
       :unnarrowed t)

     ;; life lessons and quotes
       ("eb" "life lessons and quotes" entry (file "~/Dropbox/Org/exclusive/hLifeLessons.org")
        "* %a \n%T\n#+person: %^{person}\n#+description: %i\n\n** Quote: %?"
         :empty-lines 1
         :prepend t
         :unnarrowed t)

       ;;
       ;; schedule
       ;;
          ("s" "schedule")

       ;; todo
      ("sa" "TODO" entry (file+datetree "~/Dropbox/Org/exclusive/schedule.org")
       "* TODO: %^{TODO}"
        :empty-lines 1
        :unnarrowed t)

      	;; todo + deadline
        ("sb" "TODO + deadline" entry (file "~/Dropbox/Org/exclusive/schedule.org")
         "* TODO: %^{TODO}\n#+deadline: %^t"
          :empty-lines 1
          :unnarrowed t)

	;; todo + deadline + place
        ("sc" "TODO + deadline + place" entry (file "~/Dropbox/Org/exclusive/schedule.org")
         "* TODO: %^{TODO}\n#+deadline: %^t\n#+place: %?"
          :empty-lines 1
          :unnarrowed t)

	;; todo + deadline + place + contact
        ("sd" "TODO + deadline + place + contact(url, email, phone)" entry (file "~/Dropbox/Org/exclusive/schedule.org")
         "* TODO: %^{TODO}\n#+deadline: %^t\n#+place: %?\n#+contact: %?"
          :empty-lines 1
          :unnarrowed t)

	;; todo + deadline + place + contact + description
        ("se" "TODO + deadline + place + contact + description" entry (file "~/Dropbox/Org/exclusive/schedule.org")
         "* TODO: %^{TODO}\n#+deadline: %^t\n#+place: %?\n#+contact: %?\n#+descriptoin: %?"
          :empty-lines 1
          :unnarrowed t)


       ;;
       ;; keyboard bindings
       ;;
          ("k" "keyboard binding")

       ;; general software
      ("ka" "general software" entry (file "~/Dropbox/Org/keyBindings.org")
       "* %^{??}\t\t:%^{software}:\n#+key binding: %^{key binding}"
        :immediate-finish t
        :prepend t
        :empty-lines 1
        :unnarrowed t)

       ;; mpv player
      ("kb" "mpv player" entry (file+headline "~/Dropbox/Org/keyBindings.org" "mpv player")
       "* %^{??}\t\t:mpv:\n#+key binding: %^{key binding}"
        :immediate-finish t
        :prepend t
        :empty-lines 1
        :unnarrowed t)

        ;; doom emacs
      ("kc" "emacs" entry (file+headline "~/Dropbox/Org/keyBindings.org" "emacs")
       "* %^{??}\t\t:emacs:\n#+key binding: %^{key binding}"
        :immediate-finish t
        :prepend t
        :empty-lines 1
        :unnarrowed t)


        ;; vim
      ("kd" "vim" entry (file+headline "~/Dropbox/Org/keyBindings.org" "vim")
       "* %^{??}\t\t:vim:\n#+key binding: %^{key binding}"
        :immediate-finish t
        :prepend t
        :empty-lines 1
        :unnarrowed t)

         ;; git
      ("ke" "git" entry (file+headline "~/Dropbox/Org/keyBindings.org" "git")
       "* %^{??}\t\t:vim:\n#+key binding: %^{key binding}"
        :immediate-finish t
        ;; :prepend t
        :empty-lines 1
        :unnarrowed t)

     ("z" "opened buffers" entry (function org-opened-buffers)
         "* %a \n%T\n%i"
      	:empty-lines 1
      	:unnarrowed t)

      ("u" "recent buffers" entry (function org-recent-buffers)
         "* %a \n%T\n%i"
      	:empty-lines 1
      	:unnarrowed t)

      ("x" "daily notes" entry (function org-journal-find-location)
         "* %a \n%T\n%i"
      	:empty-lines 1
      	:unnarrowed t)


      ("v" "new note" plain (function find-blog-post-for-capture)
        "* %a \n%T\n%i"
      	:empty-lines 1
      	:unnarrowed t)


     ;; ("a"               ; key
     ;;     "Article"         ; name
     ;;     entry             ; type
     ;;     (file+headline "~/Dropbox/Org/phd.org" "Article")  ; target
     ;;     "* %^{Title} %(org-set-tags)  :article: \n:PROPERTIES:\n:Created: %T\n:Linked: %a\n:END:\n%i\nBrief description:\n%?"  ; template
     ;;     :prepend t        ; properties
     ;;     :empty-lines 1    ; properties
     ;;     :created t        ; properties
     ;; )

   ))

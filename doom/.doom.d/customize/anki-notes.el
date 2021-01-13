


(setq anki-external-source "adsII/2020-ws-ads2-02-1s-v03.pdf"
      anki-deck "adsII")
(setq ~ (getenv "HOME"))


(use-package! anki-editor

  :after org
  :init
  ;; blah
  :config
   ;; blah

(add-to-list 'org-capture-templates
'("a" "anki notes")
  )

  (add-to-list 'org-capture-templates
    '(
      "aa" "choose file" entry (function org-recent-buffers)
"* %l\n:PROPERTIES:\n:ANKI_DECK: tuk::%^{deck|default|adsII|emsI|os|smsI|vds}
:ANKI_NOTE_TYPE: lectures\n:END:\n** Video (HTML5)\n%i
** question\n%^{question}
** topic\n%^{topic}
** notes\n%^{notes}
** external_source\n%(print anki-external-source)\n** external_page\n%^{page no:}"
       :empty-lines 2
       :unnarrowed t
       :immediate-finish t)
    )

  (add-to-list 'org-capture-templates
    '(
      "ab" "deck :: fixed" entry (file "~/Nextcloud/org/fixedDeck.org")
"* %i\n:PROPERTIES:\n:ANKI_DECK: tuk::%(print anki-deck)
:ANKI_NOTE_TYPE: lectures\n:END:\n** question :drill:\n%^{question}
*** topic\n%^{topic}
*** notes\n%^{notes}%?
** external_source\n%(print anki-external-source)\n** external_page\n%^{page no:}"
      :empty-lines 2
      :unnarrowed t
      :immediate-finish t)
      )


  (add-to-list 'org-capture-templates
    '(
      "ac" "quick img" entry (file "~/Nextcloud/org/fixedDeck.org")
      "* %^{slide name}\n#+url: %i"
      :empty-lines 1
      :unnarrowed t
      :immediate-finish t)
      )
)

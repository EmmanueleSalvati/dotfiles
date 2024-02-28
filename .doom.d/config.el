;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; This is from this guide
;; https://github.com/james-stoup/emacs-org-mode-tutorial

;; Make Org mode work with files ending in .org
(require 'org)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; The above is the default in recent emacsen
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(define-key global-map "\C-cc" 'org-capture)
;;(map! "\C-cc" 'org-capture)

;; Remap the change priority keys to use the UP or DOWN key
(define-key org-mode-map (kbd "C-c <up>") 'org-priority-up)
(define-key org-mode-map (kbd "C-c <down>") 'org-priority-down)

;; When a TODO is set to a done state, record a timestamp
(setq org-log-done 'time)

;; Make the indentation look nicer
(add-hook 'org-mode-hook 'org-indent-mode)

;; When you want to change the level of an org item, use SMR
(define-key org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)
;;(map! org-mode-map (kbd "C-c C-g C-r") 'org-shiftmetaright)

;; Hide the markers so you just see bold text as BOLD-TEXT and not *BOLD-TEXT*
(setq org-hide-emphasis-markers t)

;; Wrap the lines in org mode so that things are easier to read
(add-hook 'org-mode-hook 'visual-line-mode)

;; TODO states
(setq org-todo-keywords
      '((sequence "TODO(t)" "PLANNING(p)" "IN-PROGRESS(i@/!)" "VERIFYING(v!)" "BLOCKED(b@)"  "|" "DONE(d!)" "OBE(o@!)" "WONT-DO(w@/!)" )
        ))

;; TODO colors
(setq org-todo-keyword-faces
      '(
        ("TODO" . (:foreground "GoldenRod" :weight bold))
        ("PLANNING" . (:foreground "DeepPink" :weight bold))
        ("IN-PROGRESS" . (:foreground "Cyan" :weight bold))
        ("VERIFYING" . (:foreground "DarkOrange" :weight bold))
        ("BLOCKED" . (:foreground "Red" :weight bold))
        ("DONE" . (:foreground "LimeGreen" :weight bold))
        ("OBE" . (:foreground "LimeGreen" :weight bold))
        ("WONT-DO" . (:foreground "LimeGreen" :weight bold))
        ))

(setq org-capture-templates
      '(
        ("g" "General To-Do"
         entry (file+headline "~/org/todos.org" "General Tasks")
         "* TODO [#B] %?\n:Created: %T\n "
         :empty-lines 0)

        ("j" "Work Log Entry"
         entry (file+datetree "~/org/work-log.org")
         "* %?"
         :empty-lines 0)

        ("c" "Code To-Do"
         entry (file+headline "~/org/todos.org" "Code Related Tasks")
         "* TODO [#B] %?\n:Created: %T\n%i\n%a\nProposed Solution: "
         :empty-lines 0)

        ("m" "Meeting"
         entry (file+datetree "~/org/meetings.org")
         "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#A] "
         :tree-type week
         :clock-in t
         :clock-resume t
         :empty-lines 0)

        ))

;; Tags
(setq org-tag-alist '(
                      ;; Timeline types
                      (:startgroup . nil)
                      ("this week" . ?W)
                      ("today"     . ?T)
                      (:endgroup . nil)

                      ;; Work types
                      (:startgroup . nil)
                      ("reading" . ?r)
                      ("writing" . ?w)
                      ("coding" . ?c)
                      ("analysis" . ?a)
                      (:endgroup . nil)

                      ;; Meeting types
                      (:startgroup . nil)
                      ("interview" . ?i)
                      ("customer" . ?C)
                      ("passive" . ?p)
                      ("useful" . ?u)
                      (:endgroup . nil)

                      ;; Project TODOs tags
                      ("APFIT" . ?A)
                      ("PREP" . ?P)

                      ;; Special tags
                      ("CRITICAL" . ?x)
                      ("obstacle" . ?o)

                      ;; Meeting tags
                      ("HR" . ?h)
                      ("Sick-Pers" . ?s)
                      ("ITS" . ?I)
                      ("misc" . ?z)
                      ("planning" . ?p)

                      ;; Work Log Tags
                      ("accomplishment" . ?A)
                      ))

;; Tag colors
(setq org-tag-faces
      '(
        ("writing"   . (:foreground "mediumPurple1" :weight bold))
        ("coding"    . (:foreground "royalblue1"    :weight bold))
        ("analysis"  . (:foreground "forest green"  :weight bold))
        ("PREP"      . (:foreground "sienna"        :weight bold))
        ("APFIT"     . (:foreground "yellow1"       :weight bold))
        ("CRITICAL"  . (:foreground "red1"          :weight bold))
        )
      )

(setq org-agenda-custom-commands
      '(
        ;; James's Super View
        ("j" "James's Super View"
         (
          (agenda ""
                  (
                   (org-agenda-remove-tags t)
                   (org-agenda-span 7)
                   )
                  )

          (alltodo ""
                   (
                    ;; Remove tags to make the view cleaner
                    (org-agenda-remove-tags t)
                    (org-agenda-prefix-format "  %t  %s")
                    (org-agenda-overriding-header "CURRENT STATUS")

                    ;; Define the super agenda groups (sorts by order)
                    (org-super-agenda-groups
                     '(
                       ;; Filter where tag is CRITICAL
                       (:name "Critical Tasks"
                              :tag "CRITICAL"
                              :order 0
                              )
                       ;; Filter where TODO state is IN-PROGRESS
                       (:name "Currently Working"
                              :todo "IN-PROGRESS"
                              :order 1
                              )
                       ;; Filter where TODO state is PLANNING
                       (:name "Planning Next Steps"
                              :todo "PLANNING"
                              :order 2
                              )
                       ;; Filter where TODO state is BLOCKED or where the tag is obstacle
                       (:name "Problems & Blockers"
                              :todo "BLOCKED"
                              :tag "obstacle"
                              :order 3
                              )
                       ;; Filter where tag is @write_future_ticket
                       (:name "Tickets to Create"
                              :tag "@write_future_ticket"
                              :order 4
                              )
                       ;; Filter where tag is @research
                       (:name "Research Required"
                              :tag "@research"
                              :order 7
                              )
                       ;; Filter where tag is meeting and priority is A (only want TODOs from meetings)
                       (:name "Meeting Action Items"
                              :and (:tag "meeting" :priority "A")
                              :order 8
                              )
                       ;; Filter where state is TODO and the priority is A and the tag is not meeting
                       (:name "Other Important Items"
                              :and (:todo "TODO" :priority "A" :not (:tag "meeting"))
                              :order 9
                              )
                       ;; Filter where state is TODO and priority is B
                       (:name "General Backlog"
                              :and (:todo "TODO" :priority "B")
                              :order 10
                              )
                       ;; Filter where the priority is C or less (supports future lower priorities)
                       (:name "Non Critical"
                              :priority<= "C"
                              :order 11
                              )
                       ;; Filter where TODO state is VERIFYING
                       (:name "Currently Being Verified"
                              :todo "VERIFYING"
                              :order 20
                              )
                       )
                     )
                    )
                   )
          ))
        ))

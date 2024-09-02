(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/Code/crafted-emacs/modules/crafted-init-config")

(require 'crafted-startup-config)
(require 'crafted-defaults-config)

(defvar es/default-font-size 100)
(defvar es/default-variable-font-size 100)
(when (eq system-type 'darwin)
  (setq es/default-font-size 180
	es/default-variable-font-size 180))
(when (equal (system-name) "yarnbaby")
  (setq es/default-font-size 150
	es/default-variable-font-size 150))
(defvar es/frame-transparency '(99 . 99))

(defun es/set-font-faces ()
  (message "Setting font faces!")

  (set-face-attribute 'default nil :font "Iosevka" :height es/default-font-size)
  (set-face-attribute 'fixed-pitch nil :font "Iosevka" :height es/default-font-size)
  (set-face-attribute 'variable-pitch nil :font "Iosevka" :height es/default-variable-font-size :weight 'regular))

(if (daemonp)
    (add-hook 'after-make-frame-functions
	      (lambda (frame)
		(setq doom-modeline-icon t)
		(with-selected-frame frame
		  (es/set-font-faces))))
  (es/set-font-faces))

(add-to-list 'package-selected-packages 'doom-themes)
(package-install-selected-packages :noconfirm)

(load-theme 'doom-palenight)

(require 'crafted-ui-packages)
(package-install-selected-packages :noconfirm)
(require 'crafted-ui-config)

(add-to-list 'package-selected-packages 'doom-modeline)
(package-install-selected-packages :noconfirm)
(require 'doom-modeline)
(add-hook 'after-init-hook #'doom-modeline-mode)

(with-eval-after-load 'org
  (org-babel-do-load-languages
   'org-babel-load-langagues '((emacs-lisp . t) (python . t)))

  (push '("conf-unix" . conf-unix) org-src-lang-modes))

(require 'crafted-completion-packages)

(require 'crafted-ide-packages)
(require 'crafted-ide-config)
(add-hook 'prog-mode-hook #'aggressive-indent-mode)
(crafted-ide-eglot-auto-ensure-all)
(crafted-ide-configure-tree-sitter '(css html python))

(add-to-list 'package-selected-packages 'rainbow-delimiters)
(package-install-selected-packages :noconfirm)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)

(require 'crafted-org-config)
(add-to-list 'package-selected-packages 'org-roam)
(package-install-selected-packages :noconfirm)

(add-to-list 'package-selected-packages 'visual-fill-column)
(package-install-selected-packages :noconfirm)

(defun es/org-mode-visual-fill ()
  (customize-set-variable 'visual-fill-column-width 140)
  (customize-set-variable 'visual-fill-column-center-text t)

  (visual-fill-column-mode 1))

(add-hook 'org-mode-hook #'es/org-mode-visual-fill)

(add-to-list 'package-selected-packages 'org-bullets)
(package-install-selected-packages :noconfirm)
(add-hook 'org-mode-hook #'org-bullets-mode)
(customize-set-variable 'org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●"))

(defun es/org-font-setup ()
  ;; Replace list hyphen with dot
  (font-lock-add-keywords 'org-mode
                          '(("^ *\\([-]\\) "
                             (0 (prog1 () (compose-region (match-beginning 1) (match-end 1) "•"))))))

  ;; Set faces for heading levels
  (dolist (face '((org-level-1 . 1.2)
                  (org-level-2 . 1.1)
                  (org-level-3 . 1.05)
                  (org-level-4 . 1.0)
                  (org-level-5 . 1.1)))
    (set-face-attribute (car face) nil :font "Iosevka" :weight 'regular :height (cdr face)))

  ;; Ensure that anything that should be fixed-pitch in Org files appears that way
  (set-face-attribute 'org-block nil    :foreground nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil    :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil  :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil     :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-table nil    :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil  :inherit 'fixed-pitch)
  (set-face-attribute 'line-number nil :inherit 'fixed-pitch)
  (set-face-attribute 'line-number-current-line nil :inherit 'fixed-pitch))

(add-hook 'org-mode-hook #'es/org-font-setup)

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

(require 'crafted-org-config)
(add-to-list 'package-selected-packages 'org-roam)

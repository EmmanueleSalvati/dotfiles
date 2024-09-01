(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (and custom-file
           (file-exists-p custom-file))
  (load custom-file nil :nomessage))

(load "~/Code/crafted-emacs/modules/crafted-init-config")

(require 'crafted-startup-config)
(require 'crafted-defaults-config)
(require 'crafted-completion-packages)
(require 'crafted-ide-packages)
(require 'crafted-org-packages)
(add-to-list 'package-selected-packages 'org-roam)

(package-install-selected-packages :noconfirm)

(require 'crafted-ide-config)

(add-hook 'prog-mode-hook #'aggressive-indent-mode)
(crafted-ide-eglot-auto-ensure-all)
(crafted-ide-configure-tree-sitter '(css html python))

(require 'crafted-org-config)

;; add crafted-completion package definitions to selected packages list

(require 'crafted-completion-config)

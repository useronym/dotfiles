(require 'package)
  (push '("marmalade" . "http://marmalade-repo.org/packages/")
                package-archives )
  (push '("melpa" . "http://melpa.milkbox.net/packages/")
                package-archives)
  (package-initialize)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq scroll-step 1) ;; keyboard scroll one line at a time

(require 'evil)
  (evil-mode 1)

(load-file (let ((coding-system-for-read 'utf-8))
                (shell-command-to-string "agda-mode locate")))

(add-hook 'evil-insert-state-entry-hook (lambda () (set-input-method "Agda")))
(add-hook 'evil-insert-state-exit-hook (lambda () (set-input-method nil)))

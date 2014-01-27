(defcustom addon-smex
  nil
  "Enable smex features"
  :type 'boolean
  :group 'features)

(when addon-smex
  (progn
    (add-to-list 'my-default-packages 'smex)
    (try-require 'smex)))

(after 'smex
  (smex-initialize)

  ;; Replace default "M-x" functionality
  (global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "S-M-x") 'smex-major-mode-commands)
  ;; expose the old "M-x"
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)
  
  ;; Modify smex so that typing a space will insert a hyphon '-' like normal M-x
  (defadvice smex (around space-inserts-hyphen activate compile)
    (let ((ido-cannot-complete-command
           `(lambda ()
              (interactive)
              (if (string= " " (this-command-keys))
                  (insert ?-)
                (funcall ,ido-cannot-complete-command)))))
      ad-do-it))

  ;; Tell smex to update cache when new functions are loaded
  (defun smex-update-after-load (unused)
    (when (boundp 'smex-cache)
      (smex-update)))
  (add-hook 'after-load-functions 'smex-update-after-load))
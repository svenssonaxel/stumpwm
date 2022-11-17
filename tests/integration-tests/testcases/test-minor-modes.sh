#!/bin/bash
set -ex

# Test the minor modes functonality

# Add the example minor mode from ../../../minor-modes.lisp to the stumpwm init file (except add the :interactive flag), and bind it to C-t u
cat >> ~/.stumpwm.d/init.lisp <<EOF
(define-minor-mode evil-mode () ()
  (:interactive t)
  (:scope :unscoped)
  (:top-map '(("j" . "move-focus down")
              ("k" . "move-focus up")
              ("h" . "move-focus left")
              ("l" . "move-focus right")
              ("x" . *exchange-window-map*)
              ("C-m b" . "evil-echo")))
  (:lighter "EVIL")
  (:lighter-make-clickable nil))

(define-key *root-map* (kbd "u") "evil-mode")
EOF

start-xvfb-with-max-resolution 2000 2000
start-stumpwm
set-resolution 640 480

open-test-window
open-test-window
open-test-window
open-test-window
stumpwm-cmd hsplit
stumpwm-cmd vsplit
stumpwm-cmd move-focus right
stumpwm-cmd vsplit

screenshot topright
stumpwm-cmd move-focus left
screenshot topleft
stumpwm-cmd move-focus down
screenshot bottomleft
stumpwm-cmd move-focus right
screenshot bottomright

send-keys C-t u k
screenshot topright-evil
send-keys h
screenshot topleft-evil
send-keys j
screenshot bottomleft-evil
send-keys l
screenshot bottomright-evil

for quarter in topright topleft bottomleft bottomright; do
    screenshots-match "$quarter" "${quarter}-evil"
    for quarter2 in topright topleft bottomleft bottomright; do
        if ! [ "$quarter" == "$quarter2" ]; then
            screenshots-differ "$quarter" "$quarter2"
        fi
    done
done

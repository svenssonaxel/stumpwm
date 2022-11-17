#!/bin/bash
set -ex

# Initialize and open two windows side by side.
start-xvfb-with-max-resolution 2000 2000
start-stumpwm
set-resolution 1000 1000
stumpwm-cmd eval '(setf *suppress-frame-indicator* t)'
open-test-window-blank
open-test-window-xlogo
stumpwm-cmd hsplit
check-invariants 1
screenshot 2
stumpwm-cmd resize 3 0
check-invariants 3

# Check that changing and restoring the resolution doesn't change anything.
screenshot 4
set-resolution 200 1000
screenshot 5
check-invariants 6
set-resolution 1000 1000
screenshot 7
check-invariants 4
screenshots-differ 2 4
screenshots-differ 4 5
screenshots-match 4 7

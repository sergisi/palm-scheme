#!/usr/bin/awk -f

/theme/ {print "theme=\"catppuccin_macchiato\""}
! /theme/ {print $0}

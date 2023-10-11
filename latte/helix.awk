#!/usr/bin/awk -f

/theme/ {print "theme=\"catppuccin_latte\""}
! /theme/ {print $0}

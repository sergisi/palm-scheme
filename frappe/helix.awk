#!/usr/bin/awk -f

/theme/ {print "theme=\"catppuccin_frappe\""}
! /theme/ {print $0}

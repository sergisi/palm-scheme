#!/usr/bin/awk -f

/theme/ {print "theme=\"catppuccin_mocha\""}
! /theme/ {print $0}

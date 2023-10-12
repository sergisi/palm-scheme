#!/usr/bin/bash
if [ "$1" = "" ] 
then
  echo "Provide the theme to change"
  exit
fi
echo "Changing theme to $1"
awk -f $1/helix.awk /home/sergi/.config/helix/config.toml > /home/sergi/.config/helix/other.toml
mv /home/sergi/.config/helix/other.toml /home/sergi/.config/helix/config.toml
rm -rf current-theme/ && cp "$1" current-theme -r && eww reload  # just copies and reloads bar.
mv /home/sergi/.config/palm-scheme/current-theme/spt.yml /home/sergi/.config/spotify-tui/config.yml
for pid in $(pidof kitty)
do 
  kill -s USR1 $pid
done
case "$1" in
  mocha) 
    gtktheme="Catppuccin-Mocha-Standard-Peach-Dark"
  ;;
  macchiato) 
    gtktheme="Catppuccin-Macchiato-Standard-Peach-Dark"
  ;;
  frappe) 
    gtktheme="Catppuccin-Frappe-Standard-Peach-dark"
  ;;
  latte) 
    gtktheme="Catppuccin-Latte-Standard-Peach-light"
  ;;
esac

if [ "$gtktheme" != "" ] 
then
  echo "$gtktheme"
  gsettings set org.gnome.desktop.interface gtk-theme $gtktheme
fi
savePath=/home/sergi/.config/gtk-3.0/settings.ini
awk '/gtk-theme-name/ {print "gtk-theme-name='$gtktheme'"}! /gtk-theme-name/ { print $0}' $savePath >> settings.ini
mv settings.ini $savePath

#!/usr/bin/bash
if [ "$1" = "" ] 
then
  echo "Provide the theme to change"
  exit
fi
workdir="/home/sergi/.config/palm-scheme"
config="/home/sergi/.config"
nvimConfig="/home/sergi/.config/nvim"
rm -rf $workdir/current-theme/ && cp "$workdir/$1" $workdir/current-theme -r && eww reload  # just copies and reloads bar.
mv /home/sergi/.config/palm-scheme/current-theme/spt.yml /home/sergi/.config/spotify-tui/config.yml
mv /home/sergi/.config/palm-scheme/current-theme/zathurarc /home/sergi/.config/zathura/zathurarc
mv /home/sergi/.config/palm-scheme/current-theme/mako-config /home/sergi/.config/mako/config 
makoctl reload
for pid in $(pidof kitty)
do 
  kill -s USR1 $pid
done
theme=$1
case "$1" in
  mocha) 
    gtktheme="Catppuccin-Mocha-Standard-Peach-Dark"
    theme="catppuccin-$1"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    ;;
  macchiato) 
    gtktheme="Catppuccin-Macchiato-Standard-Peach-Dark"
    theme="catppuccin-$1"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    ;;
  frappe) 
    gtktheme="Catppuccin-Frappe-Standard-Peach-dark"
    theme="catppuccin-$1"
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    ;;
  latte) 
    gtktheme="Catppuccin-Latte-Standard-Peach-light"
    theme="catppuccin-$1"
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    ;;
  gruvbox-light)
    gtktheme="Gruvbox-Light"
    sed -i 's/vim.o.background.*/vim.o.background = "light"/1' "$nvimConfig/init.lua"
    theme=gruvbox
    gsettings set org.gnome.desktop.interface color-scheme prefer-light
    ;;
  gruvbox-dark)
    gtktheme="Gruvbox-Dark"
    sed -i 's/vim.o.background.*/vim.o.background = "dark"/1' "$nvimConfig/init.lua"
    theme=gruvbox
    gsettings set org.gnome.desktop.interface color-scheme prefer-dark
    ;;
esac

# Only touch the GTK theme when we know which one belongs to this scheme;
# otherwise settings.ini would get an empty gtk-theme-name.
if [ "$gtktheme" != "" ]
then
  echo "$gtktheme"
  gsettings set org.gnome.desktop.interface gtk-theme "$gtktheme"
  case "$gtktheme" in
    *[Ll]ight) preferDark=0 ;;
    *) preferDark=1 ;;
  esac
  savePath=$config/gtk-3.0/settings.ini
  tmp=$(mktemp)
  awk -v theme="$gtktheme" -v dark="$preferDark" '
    /^gtk-theme-name=/ { print "gtk-theme-name=" theme; next }
    /^gtk-application-prefer-dark-theme=/ { print "gtk-application-prefer-dark-theme=" dark; next }
    { print }' "$savePath" > "$tmp" && cat "$tmp" > "$savePath"
  rm -f "$tmp"
fi
cp "$workdir/current-theme/config-swaylock" "$config/swaylock/config"

hyprctl reload config-only
swaync-client --reload-css
eww reload

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
for pid in $(pidof kitty)
do 
  kill -s USR1 $pid
done

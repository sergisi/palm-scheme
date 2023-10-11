# palm-scheme

My system currently has no means to change the color schemes.

I usually alter between the different flavours of Catppuccin,
as for slides and working on my big screen I find the bright theme
best. Meanwhile, when I'm doing work on my laptop, I usually want to
change it back to the dark-scheme.

Although with modern UI's it's already done outside of the box, with my
Hyprland configuration I take some time to change all the files the way
I want them.

## The tool The tool will consist of bash scripts for portability,
and also because we will be mostly managing files. It will:

1. Each subfolder will be the current theme. The special directory
   ~.current-theme~ will have the current theme, and all the apps will
   reference to it.
2. The theme will have a script.sh that changes all the ones that do
   not rely on a file as a configuration, but as a parameter
3. The main script will copy the selected theme to the current theme, and
   run script.sh to change the colors programatically.



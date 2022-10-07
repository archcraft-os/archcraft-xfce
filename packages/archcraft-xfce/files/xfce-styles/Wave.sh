#!/usr/bin/env bash

## Dirs #############################################
terminal_path="$HOME/.config/xfce4/terminal"
geany_path="$HOME/.config/geany"

# wallpaper ---------------------------------
set_wall() {
	SCREEN=`xrandr --listactivemonitors | awk -F ' ' 'END {print $1}' | tr -d \:`
	MONITOR=`xrandr --listactivemonitors | awk -F ' ' 'END {print $2}' | tr -d \*+`
	xfconf-query --channel xfce4-desktop --property /backdrop/screen${SCREEN}/monitor${MONITOR}/workspace0/last-image --set /usr/share/backgrounds/"${1}"
}

# xfce terminal ---------------------------------
change_xfterm () {
	sed -i -e "s/FontName=.*/FontName=$1/g" "$terminal_path"/terminalrc
	sed -i -e 's/ColorForeground=.*/ColorForeground=#f8f8f8f8f2f2/g' 	"$terminal_path"/terminalrc
	sed -i -e 's/ColorBackground=.*/ColorBackground=#32323f3f4e4e/g' 	"$terminal_path"/terminalrc
	sed -i -e 's/ColorCursor=.*/ColorCursor=#f8f8f8f8f2f2/g' 			"$terminal_path"/terminalrc
	sed -i -e 's/ColorPalette=.*/ColorPalette=#3d3d4c4c5f5f;#f4f48f8fb1b1;#a1a1efefd3d3;#f1f1fafa8c8c;#9292b6b6f4f4;#bdbd9999ffff;#8787dfdfebeb;#f8f8f8f8f2f2;#565668687e7e;#eeee4f4f8484;#5353e2e2aeae;#f1f1ffff5252;#64649898efef;#98985e5effff;#2424d1d1e7e7;#e5e5e5e5e5e5/g' "$terminal_path"/terminalrc
}

# geany ---------------------------------
change_geany() {
	sed -i -e "s/color_scheme=.*/color_scheme=$1.conf/g" "$geany_path"/geany.conf
	sed -i -e "s/editor_font=.*/editor_font=$2/g" "$geany_path"/geany.conf
}

# gtk theme, icons and fonts ---------------------------------
change_gtk() {
	xfconf-query -c xfwm4 -p /general/theme -s "${1}"
	xfconf-query -c xsettings -p /Net/ThemeName -s "${2}"
	xfconf-query -c xsettings -p /Net/IconThemeName -s "${3}"
	xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "${4}"
	xfconf-query -c xsettings -p /Gtk/FontName -s "${5}"
}

# notify ---------------------------------
notify_user () {
	local style=`basename $0` 
	notify-send -u normal -i /usr/share/icons/Archcraft/actions/24/channelmixer.svg "Applying Style : ${style%.*}"
}

## Execute Script -----------------------
notify_user

# Set Wallpaper
set_wall 'wave.jpg'

## Change colors in funct (xfce4-terminal)
change_xfterm 'JetBrainsMono Nerd Font 10'

# SCHEME | FONT
change_geany 'wave' 'JetBrains Mono 10'

# WM THEME | THEME | ICON | CURSOR | FONT
change_gtk 'Wave' 'Wave' 'Luv-Folders-Dark' 'Vimix' 'Noto Sans 9'

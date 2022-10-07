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
	sed -i -e 's/ColorForeground=.*/ColorForeground=#c4c4c7c7c5c5/g' 	"$terminal_path"/terminalrc
	sed -i -e 's/ColorBackground=.*/ColorBackground=#22222d2d3232/g' 	"$terminal_path"/terminalrc
	sed -i -e 's/ColorCursor=.*/ColorCursor=#c4c4c7c7c5c5/g' 			"$terminal_path"/terminalrc
	sed -i -e 's/ColorPalette=.*/ColorPalette=#262636364040;#ecec78787575;#6161c7c76666;#fdfdd8d83535;#4242a5a5f5f5;#baba6868c8c8;#4d4dd0d0e1e1;#bfbfbabaacac;#4a4a69697d7d;#fbfb87878484;#7070d6d67575;#ffffe7e74444;#5151b4b4ffff;#c9c97979d7d7;#5c5cdfdff0f0;#fdfdf6f6e3e3/g' "$terminal_path"/terminalrc
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
set_wall 'adaptive.png'

## Change colors in funct (xfce4-terminal)
change_xfterm 'JetBrainsMono Nerd Font 10'

# SCHEME | FONT
change_geany 'adapta' 'JetBrains Mono 10'

# WM THEME | THEME | ICON | CURSOR | FONT
change_gtk 'Adapta-Nokto' 'Adapta-Nokto' 'Luv-Folders-Dark' 'Vimix' 'Noto Sans 9'

#!/usr/bin/env bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Script To Apply Themes

## Theme ------------------------------------
THEME="$1"
THEME_FILE="$HOME/.config/xfce-themes/${THEME}.bash"

if [[ -z "$THEME" ]]; then
	echo "Missing Theme Argument!"
	exit 1
fi

if [[ -f "$THEME_FILE" ]]; then
	source "$THEME_FILE"
else
	echo "Theme Not Available : $THEME"
	exit 1
fi

## Directories ------------------------------
PATH_CONF="$HOME/.config"
PATH_GEANY="$PATH_CONF/geany"
PATH_XFCE="$PATH_CONF/xfce4/terminal"

## wallpaper --------------------------------
apply_wallpaper() {
	SCREEN=`xrandr --listactivemonitors | awk -F ' ' 'END {print $1}' | tr -d \:`
	MONITOR=`xrandr --listactivemonitors | awk -F ' ' 'END {print $2}' | tr -d \*+`
	xfconf-query --channel xfce4-desktop --property /backdrop/screen${SCREEN}/monitor${MONITOR}/workspace0/last-image --set "${wallpaper}"
}

## xfce terminal ----------------------------
apply_terminal() {
	sed -i ${PATH_XFCE}/terminalrc \
		-e "s/FontName=.*/FontName=$terminal_font_name $terminal_font_size/g" \
		-e "s/ColorBackground=.*/ColorBackground=${background}/g" \
		-e "s/ColorForeground=.*/ColorForeground=${foreground}/g" \
		-e "s/ColorCursor=.*/ColorCursor=${foreground}/g" \
		-e "s/ColorPalette=.*/ColorPalette=${color0};${color1};${color2};${color3};${color4};${color5};${color6};${color7};${color8};${color9};${color10};${color11};${color12};${color13};${color14};${color15}/g"
}

## geany ------------------------------------
apply_geany() {
	sed -i ${PATH_GEANY}/geany.conf \
		-e "s/color_scheme=.*/color_scheme=$geany_colors/g" \
		-e "s/editor_font=.*/editor_font=$geany_font/g"
}

## Appearance -------------------------------
apply_appearance() {
	xfconf-query -c xfwm4 -p /general/theme -s "$xfwm_theme"
	xfconf-query -c xsettings -p /Gtk/FontName -s "$gtk_font"
	xfconf-query -c xsettings -p /Net/ThemeName -s "$gtk_theme"
	xfconf-query -c xsettings -p /Net/IconThemeName -s "$icon_theme"
	xfconf-query -c xsettings -p /Gtk/CursorThemeName -s "$cursor_theme"
	
	if [[ -f "$HOME"/.icons/default/index.theme ]]; then
		sed -i -e "s/Inherits=.*/Inherits=$cursor_theme/g" "$HOME"/.icons/default/index.theme
	fi	
}

## Create Theme File ------------------------
create_file() {
	theme_file="$HOME/.config/xfce-themes/.current"
	if [[ ! -f "$theme_file" ]]; then
		touch ${theme_file}
	fi
	echo "${THEME^}" > ${theme_file}
}

## notify -----------------------------------
notify_user() {
	notify-send -u normal -h string:x-dunst-stack-tag:applytheme -i /usr/share/icons/Archcraft/actions/24/channelmixer.svg "Applying Style : ${THEME^}"
}

## Execute Script ---------------------------
notify_user
create_file
apply_wallpaper
apply_terminal
apply_geany
apply_appearance

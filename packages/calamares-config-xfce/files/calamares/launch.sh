#!/usr/bin/bash

## Copyright (C) 2020-2024 Aditya Shakya <adi1090x@gmail.com>

## Check if booted using 'Copy to RAM' mode
DIR="/etc/calamares"
KERNEL=`uname -r`

if [[ -d "/run/archiso/copytoram" ]]; then
	sudo sed -i -e 's|/run/archiso/bootmnt/arch/x86_64/airootfs.sfs|/run/archiso/copytoram/airootfs.sfs|g' "$DIR"/modules/unpackfs.conf
	sudo sed -i -e "s|/run/archiso/bootmnt/arch/boot/x86_64/vmlinuz-linux|/usr/lib/modules/$KERNEL/vmlinuz|g" "$DIR"/modules/unpackfs.conf
fi

## Launch calamare installer accordingly
pkexec calamares -d -style kvantum

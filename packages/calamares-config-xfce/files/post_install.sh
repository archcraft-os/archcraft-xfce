#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Post installation script for Archcraft (Executes on live system, only to detect drivers in use)

##--------------------------------------------------------------------------------

## Get mount points of target system according to installer being used (calamares or abif)
if [[ `pidof calamares` ]]; then
	chroot_path="/tmp/`lsblk | grep 'calamares-root' | awk '{ print $NF }' | sed -e 's/\/tmp\///' -e 's/\/.*$//' | tail -n1`"
else
	chroot_path='/mnt'
fi

if [[ "$chroot_path" == '/tmp/' ]] ; then
	echo "+---------------------->>"
    echo "[!] Fatal error: `basename $0`: chroot_path is empty!"
fi

## Use chroot not arch-chroot
arch_chroot() {
    chroot "$chroot_path" /bin/bash -c ${1}
}

## Detect drivers in use in live session
gpu_file="$chroot_path"/var/log/gpu-card-info.bash

_detect_vga_drivers() {
    local card=no
    local driver=no

    if [[ -n "`lspci -k | grep -P 'VGA|3D|Display' | grep -w "${2}"`" ]]; then
        card=yes
        if [[ -n "`lsmod | grep -w ${3}`" ]]; then
			driver=yes
		fi
        if [[ -n "`lspci -k | grep -wA2 "${2}" | grep 'Kernel driver in use: ${3}'`" ]]; then
			driver=yes
		fi
    fi
    echo "${1}_card=$card"     >> ${gpu_file}
    echo "${1}_driver=$driver" >> ${gpu_file}
}

echo "+---------------------->>"
echo "[*] Detecting GPU card & drivers used in live session..."

# Detect AMD
_detect_vga_drivers 'amd' 'AMD' 'amdgpu'

# Detect Intel
_detect_vga_drivers 'intel' 'Intel Corporation' 'i915'

# Detect Nvidia
_detect_vga_drivers 'nvidia' 'NVIDIA' 'nvidia'

# For logs
echo "+---------------------->>"
echo "[*] Content of $gpu_file :"
cat ${gpu_file}

##--------------------------------------------------------------------------------

## Run the final script inside calamares chroot (target system)
if [[ `pidof calamares` ]]; then
	echo "+---------------------->>"
	echo "[*] Running chroot post installation script in target system..."
	arch_chroot "/usr/bin/chrooted_post_install.sh"
fi

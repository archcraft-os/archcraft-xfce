#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
## Everyone is permitted to copy and distribute copies of this file under GNU-GPL3

## Post installation script for Archcraft (only to detect nvidia)

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
nvidia_gpu_file="$chroot_path"/var/log/nvidia-gpu-card-info.bash

_detect_nvidia_drivers() {
    local nvidia_card=no
    local nvidia_driver=no

    if [[ -n "`lspci -k | grep -P 'VGA|3D|Display' | grep -w 'NVIDIA'`" ]]; then
        nvidia_card=yes
        if [[ -n "`lsmod | grep -w nvidia`" ]]; then
			nvidia_driver=yes
		fi
        if [[ -n "`lspci -k | grep -wA2 'NVIDIA' | grep 'Kernel driver in use: nvidia'`" ]]; then
			nvidia_driver=yes
		fi
    fi
    echo "nvidia_card=$nvidia_card"     >> ${nvidia_gpu_file}
    echo "nvidia_driver=$nvidia_driver" >> ${nvidia_gpu_file}
}

echo "+---------------------->>"
echo "[*] Detecting NVIDIA GPU card & drivers used in live session..."
_detect_nvidia_drivers

# For logs
echo "+---------------------->>"
echo "[*] Content of $nvidia_gpu_file :"
cat ${nvidia_gpu_file}

##--------------------------------------------------------------------------------

## Run the final script inside calamares chroot (target system)
if [[ `pidof calamares` ]]; then
	echo "+---------------------->>"
	echo "[*] Running nvidia chroot post installation script in target system..."
	arch_chroot "/usr/bin/chrooted_post_install_nvidia.sh"
fi

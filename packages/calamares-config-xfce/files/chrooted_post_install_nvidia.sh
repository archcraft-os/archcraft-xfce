#!/bin/bash

## Copyright (C) 2020-2023 Aditya Shakya <adi1090x@gmail.com>
##
## Post installation script for Archcraft (Executes on target system to perform nvidia specific operations)

## -----------------------------------------------

## mkinitcpio.conf file
init_file='/etc/mkinitcpio.conf'

## Add `kms` hook in 'init_file' file for in-tree modules (if not already present)
_add_kms() {
	if [[ ! `cat $init_file | grep 'kms'` ]]; then
		echo "+---------------------->>"
		echo "[*] Enabling 'kms' in $init_file file..."
		sed -i -e 's/modconf/modconf kms/g' /etc/mkinitcpio.conf
	fi
}

## Enable Nvidia Modules and Required Kernel Parameters
_enable_nvidia() {
	local nvidia_gpu_file='/var/log/nvidia-gpu-card-info.bash'
	
	local nvidia_card=''
	local nvidia_driver=''

	if [[ -r "$nvidia_gpu_file" ]] ; then
		echo "+---------------------->>"
		echo "[*] Getting Nvidia drivers info from $nvidia_gpu_file file..."
		source ${nvidia_gpu_file}
	else
		echo "+---------------------->>"
		echo "[!] Warning: file $nvidia_gpu_file does not exist!"
	fi

	if [[ "$nvidia_card" == 'yes' ]] ; then
		if [[ "$nvidia_driver" == 'yes' ]] ; then
			# Add nvidia modules in 'init_file' file
			if [[ `cat $init_file | grep 'MODULES="'` ]]; then
				echo "+---------------------->>"
				echo "[*] Adding Nvidia Modules in $init_file file..."
				sed -i -e 's|MODULES="|MODULES="nvidia nvidia_modeset nvidia_uvm nvidia_drm |g' ${init_file}
			else
				echo "+---------------------->>"
				echo "[*] Adding Nvidia Modules in $init_file file..."
				sed -i -e 's|MODULES=(|MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm |g' ${init_file}
			fi

			# Remove `kms` hook from 'init_file' file
			echo "+---------------------->>"
			echo "[*] Removing 'kms' from $init_file file..."
			sed -i -e 's/modconf kms/modconf/g' ${init_file}
			
			# Add kernel parameter in `/etc/default/grub` file
			echo "+---------------------->>"
			echo "[*] Adding Nvidia Kernel Parameter in '/etc/default/grub' file..."
			sed -i -e 's|GRUB_CMDLINE_LINUX_DEFAULT="quiet splash|GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nvidia_drm.modeset=1|g' /etc/default/grub
			
		fi
	fi
}

## Remove Nvidia Specific Files from Live ISO
_remove_iso_files() {
    local _files_to_remove=(
        /etc/mkinitcpio-nvidia.conf
        /etc/mkinitcpio.d/linux-nvidia.preset
    )
    local dfile

	echo "+---------------------->>"
    for dfile in "${_files_to_remove[@]}"; do 
		echo "[*] Deleting $dfile file from target system..."
		rm -rf ${dfile}
	done
}

## Execute Script
_add_kms
_enable_nvidia
_remove_iso_files

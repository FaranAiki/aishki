#!/bin/bash

#
#	(C) Copyright 2022 Muhammad Faran Aiki
#
#	Posix-Compliant Shell's Resource File.
#
#	It should be compatible with Debian, Arch, .etc!
# 	> For now, it is compatible with Arch only, haha.
#

# If not running interactively, don't do anything
echo $- | grep 'i' > /dev/null
[ "$?" = "1" ] && return

# Modify Bash's builtins
command_not_found_handle() {
		
	PROGRAM=$(echo $1 | sed 's/\([\\\/.*><!@#$%^&*()]\)/\\\1/mg' | sed 's/\[/\[/mg' | sed 's/\]/\]/mg')
	printf "\033[1;31mNo program '$1' detected.\033[m\n\n"
	
	__check_package_manager $PROGRAM && return 127
	
	if [ $ERROR_SEARCH -eq 1 ]
	then
		echo "Try to install these packages instead:"
		pacman -Fl | grep "usr/bin/$1"	
	fi
}

# Functions

_() {
	__prev_ret=$?
	$@
	return $__prev_ret
}

__get_status_color() {
	if [ $1 -eq 126 ]
	then
		printf "\033[1;96m"
	elif [ $1 -gt 0 ]
	then
		printf "\033[1;31m"
	else
		printf "\033[1;32m"
	fi
}

__check_status() {
	if [ $1 -eq 126 ]
	then
		printf "\033[1;96m126\033[m"
	elif [ $1 -gt 0 ]
	then
		printf "\033[1;31m$1\033[m"
	else
		printf "\033[1;32m0\033[m"
	fi
}

__get_directory() {
	printf "$(pwd | sed "s/$(echo $HOME | sed 's/\//\\\//mg')/\~/mg" | tr '/' '\n' | tail -n 3 | tr '\n' '/')"
}

__check_package_manager() {
	if [ $1 = 'apt' ] || [ $1 = 'apt-get' ]
	then
		printf "'apt' or 'apt-get' is part of Debian-based distribution package manager, not Arch-based, you dunce.\n"
		printf "Use 'i' (only on this system), or the vanilla 'pacman' instead.\n"
	elif [ $1 = 'apk' ]
	then
		printf "'apk' is part of Alpine-based distribution package manager, not Arch-based, you dunce.\n"
		printf "Use 'i' (only on this system), or the vanilla 'pacman' instead.\n"
	elif [ $1 = 'xbps-install' ] || [ $1 = 'xbps-remove' ]
	then
		printf "'xbps-\*' is part of Void-based distribution package manager, not Arch-based, you dunce.\n"
		printf "Use 'i' (only on this system), or the vanilla 'pacman' instead.\n"
	elif [ $1 = 'dnf' ]
	then
		printf "'dnf' is part of Fedora-based distribution package manager, not Arch-based, you dunce.\n"
		printf "Use 'i' (only on this system), or the vanilla 'pacman' instead.\n"
	else
		return 1
	fi
	
	return 0
}

# Debug functions

br() {
	clear
	exec bash
}

# Variables and exports

__add_ps_script=9

EXPLORER=thunar
EDITOR=vim
ERROR_SEARCH=1

export EXPLORER
export EDITOR
export ERROR_SEARCH

# Aliases

alias ls='ls --color=auto'
alias less='less -R'
alias sx='chmod +x'

alias pacman='sudo pacman'

alias e="thunar"
alias v="vim"
alias i="yay -Sy"
alias r="yay -R"
alias m="rhythmbox"

# PS

PS1='\[\033[1;95m\]$(_ __get_directory)\[\033[m\] [\[$(_ __get_status_color $?)\]$?\[\033[m\]]$ '
PS2='$(printf " %.0s" $(_ expr -3 + $__add_ps_script + $(_ __get_directory | _ wc -m | _ xargs expr -1 + ) + $(_ __check_status $? | _ wc -m | _ xargs expr -14 + ) | _ xargs seq); printf "... ")'

# Welcome

if [ "$USER" = "" ] || [ "$USER" =  "root" ]
then
	printf "\033[1;93mWarning\033[m, you are using root account.\n"
	printf "Flags used in this Bash are \033[1;34m'$-'.\033[m\n\n"
else
	printf "Welcome to \033[1;32mBash\033[m, \033[1;93m$USER\033[m!\n"
	printf "Flags used in this Bash are \033[1;34m'$-'.\033[m\n\n"
fi

# neofetch

# Created by `pipx` on 2023-11-25 16:18:48
export PATH="$PATH:/home/faranaiki/.local/bin"

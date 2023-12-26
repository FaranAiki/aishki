# (C) Copyright 2023 Muhammad Faran Aiki

# Functions

# Autoload
precmd_functions=precmd

# Startup
function gui_startup() {
	if [ "$USER" = "" ] || [ "$USER" =  "root" ]
	then
		printf "\033[1;93mWarning\033[m, you are using root account.\n"
		printf "Flags used in this 'zsh' are \033[1;34m'$-'.\033[m\n\n"
	else
		printf "Welcome to \033[1;32mzsh\033[m, \033[1;93m$USER\033[m!\n"
		printf "Flags used in this 'zsh' are \033[1;34m'$-'.\033[m\n\n"
	fi
	
	neofetch 
}

function cls() {
	printf '\033[2J\033[3J\033[1;1H'
}

# Install

function exifex() {
	if [ "$#" -eq 0 ]; then
		return
	fi

	if [ -e "$1" ]; then 
		$1
	fi
}

function ins() {
	FAST=false
	arg=""
	numcpu=$(( $(nproc) - 1 ))
	if [ "$#" -eq 1 ]; then
		if [ "$1" = 'fast' ] || [ "$1" = 'FAST' ]; then
			FAST=true
		else
			arg="$1"
		fi
	fi

	didrun=false
	curdir="$(pwd)"
	while [ $(pwd) != "/" ]; do
		if [ -e "./install" ]; then
			chmod +x ./install
			sudo ./install $arg
			didrun=true; break # TODO what the heck is finally equivalent to in bash?
		elif [ -e "./install.sh" ]; then
			chmod +x ./install.sh
			sudo ./install.sh $arg
			didrun=true; break
		elif [ -e "./build.sh" ]; then
			chmod +x ./build.sh
			sudo ./build.sh $arg
			didrun=true; break
		elif [ -e "./build" ]; then
			chmod +x ./build.sh
			sudo ./build $arg
			didrun=true; break
		elif [ -e "./Makefile" ] || [ -e "./makefile" ]; then
			if [ "$FAST" = true ]; then
				sudo make install -j "$numcpu"
			else
				sudo make install $arg
			fi
			didrun=true; break
		elif [ -e "./CMakeLists.txt" ]; then
			mkdir -p build
			cd build
			if ! [ -e "./CMakeFiles" ]; then
				cmake ..
			fi
	
			if [ "$FAST" = true ]; then
				cmake --build . -j "$numcpu"
			else
				cmake --build . $arg
			fi	
		
			cd -
			didrun=true; break
		elif [ -e "meson.build" ]; then
			mkdir -p build
			meson setup build
			if [ "$FAST" = true ]; then
				ninja -C build -j "$numcpu"
			else
				ninja -C build
			fi
			didrun=true; break
		elif [ -e "build.ninja" ]; then
			if [ "$FAST" = true ]; then
				ninja -C . -j "$numcpu"
			else
				ninja -C .
			fi
			didrun=true; break
		elif [ -e "../CMakeLists.txt" ]; then
			if ! [ -e "./CMakeFiles" ]; then
				cmake ..
			fi
	
			if [ "$FAST" = true ]; then
				cmake --build . -j "$numcpu"
			else
				cmake --build . $arg
			fi
			didrun=true; break
		fi
		cd ..
	done
	cd "$curdir"

	if [ "$didrun" = false ]; then
		printf "\033[0;31merror: no installation found\033[0m\n"	
	fi
}

function g() {
	if [ "$#" -eq 0 ]; then
		echo Please specify the changes made
		return
	fi

	didrun=false;
	curdir="$(pwd)"
	while [ "$(pwd)" != "/" ]; do
		if [ -e ".git" ]; then
			git add .
			git commit -m "$1"
		
			exifex ./git-push
			exifex ./.git-push
			exifex ./git_push
			exifex ./.git_push
			didrun=true; break
		fi
	done
	cd "$curdir"

	if [ "$didrun" = false ]; then
		printf "\033[0;31merror: no git found\033[0m\n"	
	fi
}

# Function
function git_branch() {
	branch=$(git branch 2> /dev/null | cut -d" " -f2-)

	if [ "$branch" = "" ];
	then
		export IN_GIT=false	
	else
		export IN_GIT=true
		echo " at <%F{green}$branch%f>"
 	fi
}

function aishki() {
	echo "Installed."
	echo "ins g exifex git_branch"
	echo "cls"
}

# Manual plugins
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# Input and prompt
setopt PROMPT_SUBST
export PROMPT='%F{yellow}(%*)%f %F{cyan}%n%f in %F{magenta}%~%f$(git_branch) [%(?.%F{green}0%f.%F{red}%?%f)]%F{blue}\$%f '
export PS1="$PROMPT"

# since I am too lazy
alias uu="sudo pacman -Syu"
alias yu="yay -Syu"
alias i="yay -S"
alias ui="yay -Sy"
alias vr="rm -Rf ~/.cache/vim/swap; rm -Rf ~/.local/share/nvim/swap; rm -Rf ~/.local/state/nvim/swap/"
alias e=nvim
alias s=surf

# Others
export EDITOR=nvim
export EDITORS=nvim
export EXPLORER=thunar
export TERMINAL=kitty

# Export application config
export KITTY_CONFIG_DIRECTORY=~/.config/kitty/

# GUI style
gui_startup

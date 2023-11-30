# Functions

# Autoload
precmd_functions=precmd

# Startup
function gui_startup() {
	neofetch 
	echo
}

# Function
function git_branch() {
	branch=$(git branch 2> /dev/null | cut -d" " -f2-)

	if [ "$branch" = "" ];
	then
		export IN_GIT=false	
	else
		export iN_GIT=true
		echo " at <%F{green}$branch%f>"
 	fi
}

# Manual plugins
source "/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source "/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "/usr/share/zsh/plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"

# Input and prompt
setopt PROMPT_SUBST
export PROMPT='%F{yellow}(%*)%f %F{cyan}%n%f in %F{magenta}%~%f$(git_branch) [%(?.%F{green}0%f.%F{red}%?%f)]%F{blue}\$$f '
export PS1="$PROMPT"

# Pacman since I am too lazy
alias upd="sudo pacman -Syu"
alias i="yay -S"
alias ui="yay -Sy"

# Others
export EDITOR=vim
export EDITORS=vim
export EXPLORER=thunar
export TERMINAL=kitty

# User checking
if [ "$USER" = "" ] || [ "$USER" =  "root" ]
then
	printf "\033[1;93mWarning\033[m, you are using root account.\n"
	printf "Flags used in this 'zsh' are \033[1;34m'$-'.\033[m\n\n"
else
	printf "Welcome to \033[1;32mzsh\033[m, \033[1;93m$USER\033[m!\n"
	printf "Flags used in this 'zsh' are \033[1;34m'$-'.\033[m\n\n"
fi

# GUI style
(gui_startup &)


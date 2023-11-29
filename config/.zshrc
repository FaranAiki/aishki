# Functions

# Autoload
precmd_functions=precmd

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
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Input and prompt
setopt PROMPT_SUBST
export PROMPT='%F{yellow}(%*)%f %F{cyan}%n%f in %F{magenta}%~%f$(git_branch) [%(?.%F{green}0%f.%F{red}%?%f)]%F{blue}\$$f '
export PS1="$PROMPT"

# Pacman since I am too lazy
upd="sudo pacman -Syu"
i="sudo pacman -S"
ui="sudo pacman -Sy"

# Others
export EDITOR=vim
export EDITORS=vim
export EXPLORER=thunar
export TERMINAL=kitty

# GUI style
(neofetch && echo & ) 


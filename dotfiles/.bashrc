#!/bin/bash

# Ignore case on auto-completion
# Note: bind used instead of sticking these in .inputrc
if [[ $iatest > 0 ]]; then bind "set completion-ignore-case on"; fi

# screw nano
export EDITOR=vim
export VISUAL=vim

# To have colors for ls and all grep commands such as grep, egrep and zgrep
export CLICOLOR=1
export LS_COLORS='no=00:fi=00:di=00;34:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:*.xml=00;31:'
export GREP_OPTIONS='--color=auto' #deprecated
alias grep="/bin/grep $GREP_OPTIONS"
unset GREP_OPTIONS

# Color for manpages in less makes manpages a little easier to read
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;31m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;44;33m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;32m'

# helpful aliases
alias cd..='cd ..'
alias ls-la='ls -la'
alias ls-al='ls -la'
alias apt-get='apt' # for the statusbar

# ------------------------------------ #
#  functions                           #
# ------------------------------------ # 

pushd() {
  if [ $# -eq 0 ]; then DIR="${HOME}"; else DIR="$1"; fi
  builtin pushd "${DIR}" > /dev/null
}

pushd_builtin() {
  builtin pushd > /dev/null
}

popd() {
  builtin popd > /dev/null
}

alias cd='pushd'
alias back='popd'
alias flip='pushd_builtin'

makelistener() {
	nc -l -v -p $1 &
}

alias nl='makelistener'

searchdb() {
	se=""
	for arg in "$@"; do 
		se+="$arg|"
	done
	se="${se::-1}" # remove last |
	awk '/^#.*('$se').*$/,/^$/' ~/db.txt | grep -A 10000 -B 10000 -E "^#.*$" # ugly hack to get highlighting
}

alias db='searchdb'

# ------------------------------------ #
#  prompt                              #
# ------------------------------------ #

function __setprompt
{
	local LAST_COMMAND=$? # Must come first!

	# Define colors
	local LIGHTGRAY="\033[0;37m"
	local WHITE="\033[1;37m"
	local BLACK="\033[0;30m"
	local DARKGRAY="\033[1;30m"
	local RED="\033[0;31m"
	local LIGHTRED="\033[1;31m"
	local GREEN="\033[0;32m"
	local LIGHTGREEN="\033[1;32m"
	local BROWN="\033[0;33m"
	local YELLOW="\033[1;33m"
	local BLUE="\033[0;34m"
	local LIGHTBLUE="\033[1;34m"
	local MAGENTA="\033[0;35m"
	local LIGHTMAGENTA="\033[1;35m"
	local CYAN="\033[0;36m"
	local LIGHTCYAN="\033[1;36m"
	local NOCOLOR="\033[0m"

    PS1=""

	# time
	PS1+="\[${DARKGRAY}\][${BLUE}$(date +'%-I':%M:%S%P)\[${DARKGRAY}\]] " # Time

	# user/server
	local SSH_IP=`echo $SSH_CLIENT | awk '{ print $1 }'`
	local SSH2_IP=`echo $SSH2_CLIENT | awk '{ print $1 }'`
	if [ $SSH2_IP ] || [ $SSH_IP ] ; then
		PS1+="[\[${RED}\]\u@\h"
	else
		PS1+="[\[${RED}\]\u"
	fi

	# current dir
	PS1+="\[${DARKGRAY}\]:\[${BROWN}\]\w\[${DARKGRAY}\]] "

	# number of jobs
	PS1+="[\[${BROWN}\]$(jobs -l | wc -l)\[${DARKGRAY}\]] "

	PS1+="\n"

	if [[ $EUID -ne 0 ]]; then
		PS1+="\[${GREEN}\]$\[${NOCOLOR}\] " # Normal user
	else
		PS1+="\[${RED}\]#\[${NOCOLOR}\] " # Root user
	fi

}
PROMPT_COMMAND='__setprompt'


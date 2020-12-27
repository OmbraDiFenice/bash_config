# get current branch in git repo
function parse_git_branch() {
	BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
	if [ ! "${BRANCH}" == "" ]
	then
		STAT=`parse_git_dirty`
		echo " [${BRANCH}${STAT}]"
	else
		echo ""
	fi
}

function print_time() {
	local time=`date +\(%H:%M:%S\)`
	
	local len=`echo $time | wc -m`
	local pos=$(( $(tput cols) - $len + 2 ))

	echo -e "\e[${pos}G${time}"
}

# get current status of git repo
function parse_git_dirty() {
	status=`git status 2>&1`
	dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
	untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
	ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
	newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
	renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
	deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
	bits=''
	if [ "${renamed}" == "0" ]; then
		bits=">${bits}"
	fi
	if [ "${ahead}" == "0" ]; then
		bits="*${bits}"
	fi
	if [ "${newfile}" == "0" ]; then
		bits="+${bits}"
	fi
	if [ "${untracked}" == "0" ]; then
		bits="?${bits}"
	fi
	if [ "${deleted}" == "0" ]; then
		bits="x${bits}"
	fi
	if [ "${dirty}" == "0" ]; then
		bits="!${bits}"
	fi
	if [ ! "${bits}" == "" ]; then
		echo " ${bits}"
	else
		echo ""
	fi
}

function get_exit_status() {
    local pipe_status=${PIPESTATUS[@]}
    if ! $(echo $pipe_status | grep -qEe '^0( 0)*$')
    then
        echo " [$pipe_status]"
    fi
}

function __prompt_command() {
    local EXIT_STATUS=$(get_exit_status) # this HAS to be the first thing done here
    local TIME=$(print_time)
    local GIT_STATUS=$(parse_git_branch)

    local Clear='\[\e[m\]'
    local DYellow='\[\e[33m\]'
    local DBlue='\[\e[34m\]'
    local Magenta='\[\e[35m\]'
    local LBlue='\[\e[36m\]'
    local White='\[\e[37m\]'
    local Red='\[\e[31m\]'

    PS1="${DBlue}\u${White}@${LBlue}\h ${DYellow}\w${Magenta}${GIT_STATUS}${Red}${EXIT_STATUS}${DBlue}${TIME}
${Magenta}\$${Clear} "
}

export PROMPT_COMMAND=__prompt_command

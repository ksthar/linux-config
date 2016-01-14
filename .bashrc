# --------------------------------------------------------------------------
# Harlan Shoop
# 07/21/14
#
# My universal bash config
# --------------------------------------------------------------------------

# --------------------------------------------------------------------------
# Setup ls aliases
#
# standard aliases, note that as of Mac 10.9, the '-o' parameter of uname is
# not recognized, so we have to use '-s'
# --------------------------------------------------------------------------
if [ "$(uname -s)" == "Darwin" ]; then
	alias ls="ls -hG";
elif [ "$(uname -s)" == "FreeBSD" ]; then
	alias ls="ls -hG";
else
	# for cygwin
	if [ "$(uname -o)" == 'Cygwin' ]; then 
		source linux-config/.minttyrc
		alias vi="vim";
	fi
	alias ls="ls -h --color=auto";
fi
alias ll="ls -l"
alias la="ls -la"

# --------------------------------------------------------------------------
# Setup tmux aliases
# 
# the '-2' is needed in some termnials to show 256 colors
# --------------------------------------------------------------------------
alias tmux="tmux -2"
alias tn="tmux new-session -s"
alias ta="tmux attach-session -t"
alias tl="tmux list-sessions"
alias td="tmux detach-client -s"
alias tk="tmux kill-session -t"
alias tr="tmux rename-session -t"

# tmux needs this for 256 colors, but revert to xterm-256color on busybox machines
if [ `uname -a | awk '/edison/ {x=1} END {print 1-x}'` == 0 ]; then
    export TERM="xterm-256color"
else
    export TERM="screen-256color"
fi

# --------------------------------------------------------------------------
# Setup prompt
# 
# change prompt colors if you are root
# --------------------------------------------------------------------------
if [ "$(whoami)" == 'root' ]; then 
	PS1="\[\033[31m\]\u@\[\033[36m\]\h:\[\033[34m\]\w\[\033[37m\] ";
else
	PS1="\[\033[32m\]\u@\[\033[36m\]\h:\[\033[34m\]\w\[\033[37m\] ";
fi



# standard aliases
alias ls="ls -h --color=auto"
alias ll="ls -l"
alias la="ls -a"

# the '-2' is needed in some termnials to show 256 colors
alias tmux="tmux -2"
alias tn="tmux new-session -s"
alias ta="tmux attach-session -t"
alias tl="tmux list-sessions"
alias td="tmux detach-client -s"
alias td="tmux kill-session -t"

# tmux needs this for 256 colors
export TERM="screen-256color"

# for cygwin
<<<<<<< HEAD
source $HOME/linux-config/.minttyrc
=======
if [ "$(uname -o)" == 'Cygwin' ]; then 
	source linux-config/.minttyrc
	alias vi="vim";
fi
>>>>>>> c00f6db672da2a301570ce224063149e6b4208d3

# my standard prompt
PS1="\[\033[32m\]\u@\[\033[36m\]\h:\[\033[34m\]\w\[\033[37m\] "


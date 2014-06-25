#!/bin/bash

MYHOST=$(hostname -s)
MYDATE=$(date | cut -c 1-3)' '$(date | cut -c 12-16)
MYEXTIP=$(curl http://whatismyip.akamai.com/)
MYINTIP=$(ifconfig -a | awk '/inet\ / { print $2 }' | awk '{ split( $0,a,":"); print a[2]}' | head -1)
echo '#[fg=white]Hostname: #[fg=yellow]#[bg=black] '$MYHOST\
' #[fg=white]#[bg=colour237] Int: #[fg=yellow]#[bg=black] '$MYINTIP\
' #[fg=white]#[bg=colour237] Ext: #[fg=yellow]#[bg=black] '$MYEXTIP\
' #[fg=black]#[bg=white] '$MYDATE' '

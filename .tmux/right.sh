#!/bin/bash

MYHOST=$(hostname -s)
MYDATE=$(date | cut -c 1-3)' '$(date | cut -c 12-16)
MYEXTIP=$(curl http://whatismyip.akamai.com/)
BATTLEFT=$(acpi -b | awk '{print$5}')
BATTSTATE=$(acpi -b | awk '{print$3}' )
if [ $BATTSTATE = "Unknown," ]; then 
	BATTLEFT="Plugged-in" 
fi
MYINTIP=$(ifconfig -a | awk '/inet\ / { print $2 }' | awk '{ split( $0,a,":"); print a[2]}' | tail -1)
echo '#[fg=white]Battery: #[fg=yellow]#[bg=black] '$BATTLEFT\
' #[fg=white]#[bg=colour237] Hostname: #[fg=yellow]#[bg=black] '$MYHOST\
' #[fg=white]#[bg=colour237] Int: #[fg=yellow]#[bg=black] '$MYINTIP\
' #[fg=white]#[bg=colour237] Ext: #[fg=yellow]#[bg=black] '$MYEXTIP\
' #[fg=black]#[bg=white] '$MYDATE' '

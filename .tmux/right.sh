#!/bin/bash

MYHOST=$(hostname -s)
MYEXTIP=$(curl http://whatismyip.akamai.com/)
#BATTLEFT=$(acpi -b | awk '{print$5}')
#BATTSTATE=$(acpi -b | awk '{print$3}' )
#if [ $BATTSTATE = "Unknown," ]; then 
#	BATTLEFT="Plugged-in" 
#fi
if [ "$(uname -o)" == "Cygwin" ]; then
	MYINTIP=$(ipconfig | awk '/IPv4\ / { print $14 }' | head -1)
	MYDATE=$(date | cut -c 1-3)' '$(date | cut -c 19-23);
else
	MYINTIP=$(ifconfig eth0 | awk '/inet\ / { print $2 }' | awk '{ split( $0,a,":"); print a[2]}' | tail -1)
	MYDATE=$(date | cut -c 1-3)' '$(date | cut -c 12-16);
fi	
#echo '#[fg=white]Battery: #[fg=yellow]#[bg=black] '$BATTLEFT\
echo ' #[fg=white]#[bg=colour237] Hostname: #[fg=yellow]#[bg=black] '$MYHOST\
' #[fg=white]#[bg=colour237] Int: #[fg=yellow]#[bg=black] '$MYINTIP\
' #[fg=white]#[bg=colour237] Ext: #[fg=yellow]#[bg=black] '$MYEXTIP\
' #[fg=black]#[bg=white] '$MYDATE' '

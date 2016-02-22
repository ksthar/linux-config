#!/bin/bash
#
# 2016-01-14
# ----------------------------------------------------------------------
# Print the right status line for tmux.  This script collects the 
# hostname, local IP, external IP, and date/time for display.  Tmux
# runs this script every few seconds.
#
# Scripting is used to make this file as universal as possible.  
# Every system has its idiosyncracies, and this file attempts to 
# adapt itself to the environment it is installed in.
# 
# Format:
#   battery | hostname | int IP | ext IP | date/time
#
# ----------------------------------------------------------------------


# ----------------------------------------------------------------------
# Hostname
# ----------------------------------------------------------------------
# This may be changed below
MYHOST=$(hostname -s)

# ----------------------------------------------------------------------
# Find External IP
# ----------------------------------------------------------------------
# if this isn't working, make sure curl is installed and you are 
# connected to the internet...
MYEXTIP=$(curl http://whatismyip.akamai.com/)

# ----------------------------------------------------------------------
# Find Battery
# ----------------------------------------------------------------------
# only do this if we have acpi installed
if [ `acpi -b | awk '/command not found/ {x=1} END {print 1-x}'` == 0 ]; then
    # Print time remaining
    #BATTLEFT=$(acpi -b | awk '{print$5}')

    # Print percent remaining
    #BATTLEFT=$(acpi -b | awk '{print$4}' | cut -f1 -s -d,)

    # Or both...
    BATTLEFT=$(acpi -b | awk '{print$4}' | cut -f1 -s -d,)' - '$(acpi -b | awk '{print$5}')
    BATTSTATE=$(acpi -b | awk '{print$3}' )
    if [ $BATTSTATE = "Unknown," ]; then 
    	BATTLEFT="Plugged-in";
    fi

    echo '#[fg=white]Battery: #[fg=yellow]#[bg=black] '$BATTLEFT
fi

# ----------------------------------------------------------------------
# Find local IP and date/time
# ----------------------------------------------------------------------
# Windows Cygwin
if [ "$(uname -o)" == "Cygwin" ]; then
	MYINTIP=$(ipconfig | awk '/IPv4\ / { print $14 }' | head -1)
	MYDATE=$(date +"%D")' '$(date | cut -c 1-3)' '$(date | cut -c 19-23);

# Mac
elif [ "$(uname -a | awk '{ print $1 }')" == "Darwin" ]; then
	MYINTIP=$(ifconfig en0 | awk '/inet\ / { print $2 }' )
	MYDATE=$(date +"%D")' '$(date | cut -c 1-3)' '$(date | cut -c 12-16);

# FreeBSD
elif [ "$(uname)" == "FreeBSD" ]; then
	MYINTIP=$(ifconfig | awk '/inet\ / { print $2 }' | head -n1)
	MYDATE=$(date +"%D")' '$(date | cut -c 1-3)' '$(date | cut -c 19-23);

# Edison: check IP of wlan0 and fix hostname
elif [ `uname -a | awk '/edison/ {x=1} END {print 1-x}'` == 0 ]; then
    MYHOST=$(hostname)
    MYDATE=$(date +"%D")' '$(date | cut -c 1-3)' '$(date | cut -c 12-16)
    MYINTIP=$(ifconfig wlan0 | awk '/inet\ / { print $2 }' | awk '{ split( $0,a,":"); print a[2]}' | tail -1);

# Generic linux: just check eth0
else
    MYINTIP=$(ifconfig eth0 | awk '/inet\ / { print $2 }' | awk '{ split( $0,a,":"); print a[2]}' | tail -1);

    MYDATE=$(date +"%D")' '$(date | cut -c 1-3)' '$(date | cut -c 12-16);
fi	

# ----------------------------------------------------------------------
# Print line
# ----------------------------------------------------------------------
echo ' #[fg=white]#[bg=colour237] Hostname: #[fg=yellow]#[bg=black] '$MYHOST\
' #[fg=white]#[bg=colour237] Int: #[fg=yellow]#[bg=black] '$MYINTIP\
' #[fg=white]#[bg=colour237] Ext: #[fg=yellow]#[bg=black] '$MYEXTIP\
' #[fg=black]#[bg=white] '$MYDATE' '


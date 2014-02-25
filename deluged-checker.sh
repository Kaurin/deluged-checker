#!/bin/bash

#
# Script which checks/controls deluged operation
# Created by Milos Kaurin
# 2012/09/02 ; Last edit: 2013/10/17
#

PATH=/bin:/usr/bin:/usr/local/bin

#
# Control variables
#

# If we want to keep deluged off, set to true
KEEPOFF=false

# Mandatory
PIDFILE="/home/username/.config/deluge/deluged.pid"

# Mandatory
LOGFILE="/home/username/.config/deluge/deluged.log"

# Mandatory, or manually comment out the mail stuff
# You need to have mail utils installed, and to have working
# outgoing email
MAILTO="me@example.com"


#
# Functions
#

# Helper mail function
function emailthis {
    echo "$@" | mail -s "Deluge-Cron at $(hostname)" "$MAILTO"
}

#
# Main loop(s)
#

# Check to see if the pid file exists
if [ ! -f "$PIDFILE" ]
then
    # If it does not, then deluged is off
    DELUGED_ON=false
else
    # If it does exist, we check if the process is running
    DELUGE_PID=$(cat "$PIDFILE" | awk -F ";" '{print $1}')
    if  kill -0 "$DELUGE_PID" > /dev/null 2>&1
    then
        DELUGED_ON=true
    else
        emailthis " deluged-cron.sh: Pid file exists, but deluged was not running."
        DELUGED_ON=false
    fi
fi

if $KEEPOFF
then
    if $DELUGED_ON
    then
        kill "$DELUGE_PID"
        emailthis " deluged-cron.sh: deluged is now off, because of the control variable"
        exit 0
    else
        exit 0
    fi
fi

# If we got here, and our checks for DELUGED_ON are false, we turn it on
# Otherwise, we just exit
if ! $DELUGED_ON
then
    if ! deluged -L info -l "$LOGFILE"
    then
        # If we fail to start deluged, we get an email notifying us
        emailthis " deluged-cron.sh: deluged failed to start!"
    fi
fi

exit 0


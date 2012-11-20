#!/bin/bash
#
# Check to see if a CC service is in ENABLED or DISABLED state using CCclient_full
# Author: Tom Ellis <tom.ellis@eucalyptus.com>
#
# Returns 1 if DISABLED or not installed
# Return 0 if ENABLED

export AXIS2C_HOME=/usr/lib64/axis2c
export LD_LIBRARY_PATH=$AXIS2C_HOME/lib:$AXIS2C_HOME/modules/rampart/

if [ -f /usr/local/bin/CCclient_full ]; then
    RETVAL=1 
    /usr/local/bin/CCclient_full 127.0.0.1:8774 describeServices | grep -q ENABLED
    RETVAL=$?
    if [ $RETVAL = "0" ]; then
       echo "Local Eucalyptus services in ENABLED state"
       exit 0
    else 
       echo "Local Eucalyptus services in DISABLED state"
       exit 1
    fi
else
    echo "CCclient_full not present"
    exit 1
fi

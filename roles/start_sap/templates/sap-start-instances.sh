#!/bin/sh
#-------------------------------------------------------------------------------------------
# EXITCODE
#    0  Last webmethod call successful
#     1  Last webmethod call failed, invalid parameter
#    2  StartWait, StopWait, WaitforStarted, WaitforStopped, RestartServiceWait timed out
#     3  GetProcessList succeeded, all processes running correctly
#     4  GetProcessList succeeded, all processes stopped
#-------------------------------------------------------------------------------------------
#set -xv
SID=$1
STARTDIR=$2

grep $SID /usr/sap/sapservices | cut -d '/' -f 5 | sed 's/[A-Z]*//g' | while read INST; do

  sh $STARTDIR/sap-start.sh $SID $INST

done

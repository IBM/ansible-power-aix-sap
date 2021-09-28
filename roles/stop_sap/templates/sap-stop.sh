#!/bin/sh
#-------------------------------------------------------------------------------------------
# EXITCODES
#    0  Last webmethod call successful
#    1  Last webmethod call failed, invalid parameter
#    2  StartWait, StopWait, WaitforStarted, WaitforStopped, RestartServiceWait timed out
#    3  GetProcessList succeeded, all processes running correctly
#    4  GetProcessList succeeded, all processes stopped
#-------------------------------------------------------------------------------------------


SID=$1
INST=$2

dir="/usr/sap/"${SID}"/SYS/exe/uc/rs6000_64"
echo "Stoping system $SID $INST"

export LIBPATH="$dir:$LIBPATH"
echo "LIBPATH: $LIBPATH"

if [ ! -d "$dir" ] || [ ! -e "$dir" ]; then # check if directory or a valid symlink
  echo "System $SID does not exist."
  exit 1;
fi

# check running SAP Instance
echo "Check running Instance "$1" no "$2" .";
$dir/sapcontrol -nr $INST -function GetProcessList

rc=$?
if [ $rc == "4" ]; then
  echo "Instance "$1" - "$2" already stopped.";
  exit 0;
fi

# stop SAP Instance
echo "Stop Instance "$1" no "$2" .";
$dir/sapcontrol -nr $INST -function Stop $SID

rc=$?
echo "Returns $rc\n\n"
if [ "$rc" -gt "0" ]; then
  echo "Failed to stop instance "$1" no "$2" .";
  exit $rc
fi

echo "Waiting for system to stop..."
$dir/sapcontrol -nr $INST -function WaitforStopped 10800 5
rc=$?
echo "Returns $rc\n\n"
if [ "$rc" -gt "0" ]; then
  if [ $rc == "2" ]; then
    echo "Stopping of instance "$1" - "$2" timed out.";
    exit 0;
  fi

  echo "Failed to stop instance "$1" no "$2" .";
  exit $rc
fi


exit $rc;

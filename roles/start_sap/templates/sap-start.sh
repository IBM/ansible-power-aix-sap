#!/bin/sh
#-------------------------------------------------------------------------------------------
# EXITCODES
#    0  Last webmethod call successful
#     1  Last webmethod call failed, invalid parameter
#    2  StartWait, StopWait, WaitforStarted, WaitforStopped, RestartServiceWait timed out
#     3  GetProcessList succeeded, all processes running correctly
#     4  GetProcessList succeeded, all processes stopped
#-------------------------------------------------------------------------------------------
#set -xv
SID=$1
INST=$2
#dir=`pwd`
dir="/usr/sap/"${SID}"/SYS/exe/uc/rs6000_64"
echo "Starting system $SID $INST"

export LIBPATH="$dir:$LIBPATH"
#echo $LIBPATH

if [ ! -d "$dir" ] || [ ! -e "$dir" ]; then # check if directory or a valid symlink
  echo "System $SID does not exist."
  exit 1;
fi

#exec "$dir/sapcontrol" "-nr $INST -function GetProcessList"
$dir/sapcontrol -nr $INST -function GetProcessList
rc=$?
if [ $rc == "3" ]; then
  echo "Instance "$1" - "$2" already started.";
  exit 0;
elif [ $rc == "1" ]; then
  echo "Starting Service "$1" no "$2" .";
  $dir/sapcontrol -nr $INST -function StartService $SID
  rc=$?
  echo "rc = "$rc;
  if [ $rc != "0" ]; then
    echo "Failed Starting Service "$1" no "$2" .";
    exit  $rc
  fi
fi


if [ $rc == "4" -o $rc == "0" ]; then
  echo "Starting Instance "$1" no "$2" .";
#  $dir/sapcontrol -nr $INST -function StartWait 300 10
  $dir/sapcontrol -nr $INST -function Start $SID
  rc1=$?
  
  echo "Returns "$rc1"\n\n"
  if [ $rc1 != "0" ]; then
    echo "Failed to start instance "$1" no "$2" .";
    exit  $rc1
  fi
  
  echo "Waiting for system to start..."
  $dir/sapcontrol -nr $INST -function WaitforStarted 10755 5
  rc=$?
  echo "Returns "$rc"\n\n"
  if [ "$rc" -gt "0" ]; then
   exit $rc
  fi

#  rc=$?
fi

if [ $rc == "3" ]; then
  echo "Instance "$1" - "$2" already started.";
  exit 0;
fi
echo "about to exit with rc = "$rc
exit $rc

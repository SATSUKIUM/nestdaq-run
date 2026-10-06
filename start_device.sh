#!/bin/bash

#MY_TERM=xterm

#libraries required
export LD_LIBRARY_PATH=$NESTDAQ/lib64:~/usr/root/lib:$LD_LIBRARY_PATH
export PATH="$NESTDAQ/bin:$PATH"

DAQSERVICE_URI=' --registry-uri tcp://127.0.0.1:5921/0'
METRICS_URI=' --metrics-uri tcp://127.0.0.1:5921/1'
CONFIG_URI=' --parameter-config-uri tcp://127.0.0.1:5921/2'

#---------------------------------------------------------
#if [[ $1 =~ fairmq- ]]; then
#  BINDIR=""
#else 
#  if [[ -x "$NESTDAQ/bin/$1" ]]; then
#    BINDIR=$NESTDAQ/bin
#  elif [[ -x "$NESTDAQUSERIMPL/bin/$1" ]]; then
#    BINDIR=$NESTDAQUSERIMPL/bin
#  else
#    echo "start_device.sh shell Error: $1 not found in bin or build directories"
#    exit 1
#  fi
#fi

if [[ $1 =~ fairmq- ]]; then
  BINDIR=""
else
  if [[ -x "$NESTDAQUSERIMPL/bin/$1" ]];then
    BINDIR=$NESTDAQUSERIMPL/bin
  elif [[ -x "$NESTDAQ/bin/$1" ]]; then
    BINDIR=$NESTDAQ/bin
  else
    echo "start_device.sh shell Error: $1 not found in bin or build directories"
    exit 1
  fi
fi

PLUGIN_LIBDIR=$NESTDAQ/lib64

PLUGIN_SEARCH_PATH=" -S '<$PLUGIN_LIBDIR'"
DAQSERVICE_PLUGIN=" -P daq_service"
METRICS_PLUGIN=" -P metrics"
CONFIG_PLUGIN=" -P parameter_config"
TELEMETRY_PLUGIN=" -P telemetry"

echo "BINDIR             = $BINDIR"
echo "PLUGIN_LIBDIR      = $PLUGIN_LIBDIR"
echo "PLUGIN_SEARCH_PATH = $PLUGIN_SEARCH_PATH"
echo "DAQSERVICE_PLUGIN  = $DAQSERVICE_PLUGIN"
echo "METRICS_PLUGIN     = $METRICS_PLUGIN"
echo "CONFIG_PLUGIN      = $CONFIG_PLUGIN"
echo "TELEMETRY_PLUGIN   = $TELEMETRY_PLUGIN"
echo "DAQSERVICE_URI     = $DAQSERVICE_URI"
echo "METRICS_URI        = $METRICS_URI"
echo "CONFIG_URI         = $CONFIG_URI"

#==============================================================================
function run_device () {
  local var;
  var+=$PLUGIN_SEARCH_PATH
  var+=$DAQSERVICE_PLUGIN
  var+=$METRICS_PLUGIN
  var+=$CONFIG_PLUGIN
  var+=$TELEMETRY_PLUGIN
  var+=$DAQSERVICE_URI
  var+=$METRICS_URI
  var+=$CONFIG_URI
  var+=" --severity debug4"

  if [ -n "$MY_TERM" ]; then
    #echo \
    $MY_TERM -title $1 -e "$BINDIR/$@ $var"
  else
    #echo \
    eval "$BINDIR/$@ $var"
  fi
}

run_device $@


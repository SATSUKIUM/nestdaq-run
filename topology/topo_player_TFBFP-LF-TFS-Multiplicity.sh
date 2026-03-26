#!/bin/bash

#host=127.0.0.1
#port=6379
#db=0
server=redis://127.0.0.1:5921/0

#function config_endpoint () {
echo "Clear DAQ service keys"
redis-cli -u $server keys 'daq_service:*' | xargs redis-cli -u $server del
function endpoint () {
  # Usage: 
  #   config_endpoint "service" "channel" "parameters"
  
  echo redis-cli -u $server hset daq_service:topology:endpoint:$1:$2 ${@:3}  
  $NESTDAQ/bin/redis-cli -u $server hset daq_service:topology:endpoint:$1:$2 ${@:3}  
}

#function config_link () {
function link () {
  # config_link "service1" "channel" "service2" "channel" "parameters"
  
  echo redis-cli -u $server set daq_service:topology:link:$1:$2,$3:$4 none
  $NESTDAQ/bin/redis-cli -u $server set daq_service:topology:link:$1:$2,$3:$4 none
}


echo "---------------------------------------------------------------------"
echo " config endpoint (socket)"
echo "---------------------------------------------------------------------"
#---------------------------------------------------------------------------
#         service           channel       options
#---------------------------------------------------------------------------

# TFB Player
endpoint TFBFilePlayer out type push method connect autoSubChannel true

endpoint LogicFilter in type pull method bind
endpoint LogicFilter out type push method connect autoSubChannel true

# # TFS
endpoint TimeFrameSlicerByLogicTiming in type pull method bind
endpoint TimeFrameSlicerByLogicTiming out type push method connect autoSubChannel true

# Sink
endpoint FileSink in type pull method bind

# High Level Filter
endpoint  FilterTimeFrameSliceByMultiplicity in type pull  method bind
endpoint  FilterTimeFrameSliceByMultiplicity out type push  method connect


echo "---------------------------------------------------------------------"
echo " config link"
echo "---------------------------------------------------------------------"
#---------------------------------------------------------------------------
#         service1          channel1       service2          channel2      
#---------------------------------------------------------------------------

link TFBFilePlayer out LogicFilter in
link LogicFilter out TimeFrameSlicerByLogicTiming in
link TimeFrameSlicerByLogicTiming out FilterTimeFrameSliceByMultiplicity in
link FilterTimeFrameSliceByMultiplicity out FileSink in

#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NESTDAQ/lib:$NESTDAQ/lib64
export PATH="$NESTDAQ/bin:$PATH"

source ./topology/Tracking.sh
source ./mq-param/mq-param_TFBFP-LF-TFS-Nothing.sh
source ./LogicFilter/triggerlogic.sh

SESSION="main"

tmux kill-session -t $SESSION 2>/dev/null
tmux new-session -d -s $SESSION -n devices

# "デバイス名 起動数"
DEVICES=(
    "TFBFilePlayer 1"
    "LogicFilter 1"
    "TimeFrameSlicerByLogicTiming 3"
    "FilterTimeFrameSliceByTrack 2"
    "FileSink 1"
)

FIRST=1

for ENTRY in "${DEVICES[@]}"; do
    read -r DEVICE COUNT <<< "$ENTRY"

    for ((i=0; i<COUNT; i++)); do

        if [ $FIRST -eq 1 ]; then
            tmux send-keys -t $SESSION:0 "./start_device.sh $DEVICE" C-m
            FIRST=0
        else
            tmux split-window -v -t $SESSION:0
            tmux send-keys -t $SESSION:0 "./start_device.sh $DEVICE" C-m
            tmux select-layout -t $SESSION:0 tiled
        fi

        sleep 0.2
    done
done

tmux attach-session -t $SESSION


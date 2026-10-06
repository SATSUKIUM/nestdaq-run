#!/bin/bash

export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NESTDAQ/lib:$NESTDAQ/lib64
export PATH="$NESTDAQ/bin:$PATH"

source ./topology/Tracking.sh
source ./mq-param/mq-param_TFBFP-LF-TFS-Nothing.sh
source ./LogicFilter/triggerlogic.sh
SESSION="main"

tmux kill-session -t $SESSION 2>/dev/null

tmux new-session -d -s $SESSION -n devices

DEVICES=(
TFBFilePlayer
LogicFilter
TimeFrameSlicerByLogicTiming
FilterTimeFrameSliceByTrack
FileSink
)

FIRST=1

for DEVICE in "${DEVICES[@]}"; do

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

tmux attach-session -t $SESSION


# #!/bin/bash

# # ライブラリパス設定
# export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$NESTDAQ/lib:$NESTDAQ/lib64

# # トポロジーとパラメータ読み込み
# source ./topology/topoPlayer_TFBFP-LF-TFS-Track.sh
# source ./mq-param/mq-param_TFBFP-LF-TFS-Nothing.sh

# # デバイスと数の定義
# declare -A DEVICES
# DEVICES=( ["TFBFilePlayer"]=1 ["LogicFilter"]=1 ["TimeFrameSlicerByLogicTiming"]=1 ["FilterTimeFrameSliceByTrack"]=1 ["FileSink"]=1 )

# # tmux セッション作成
# SESSION="main"
# tmux new-session -d -s $SESSION -n "devices"

# # 最初のペインに何も立ち上げず保持しておく
# FIRST=1

# for DEVICE in "${!DEVICES[@]}"; do
#     NUM=${DEVICES[$DEVICE]}
#     for i in $(seq 0 $((NUM-1))); do
#         if [ $FIRST -eq 1 ]; then
#             # 最初のペインにデバイス起動
#             tmux send-keys -t $SESSION:0 "./start_device.sh $DEVICE" C-m
#             FIRST=0
#         else
#             # 新しいペインを縦に分割して起動
#             tmux split-window -v -t $SESSION:0 "./start_device.sh $DEVICE"
#             tmux select-layout -t $SESSION:0 tiled
#         fi
#         sleep 0.1
#     done
# done

# sleep 1
# source ./mq-param/triggerlogic.sh

# # 最後に tmux をアタッチ
# tmux attach-session -t $SESSION

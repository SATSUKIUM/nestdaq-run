#!/bin/bash

server=redis://127.0.0.1:5921/2

function param () {
  # "instance":"field" "value"
  #echo redis-cli -u $server set parameters:$1:$2 ${@:3}
  #redis-cli -u $server set parameters:$1:$2 ${@:3}
  echo redis-cli -u $server hset parameters:$1 ${@:2}
  $NESTDAQ/bin/redis-cli -u $server hset parameters:$1 ${@:2}
}

$NESTDAQ/bin/redis-cli -u $server  flushdb

#==============================================================================
#      isntance-id       field  value    field value   field          value
# param FileSink-0 multipart true openmode append path /dev/null
# param FileSink-0 multipart true openmode append path /home/kashima/run/test_export ext .dat

# param TFBFilePlayer-0 in-file run000400.dat wait 1000
# wait 1000 は1メッセージごとに1000 ms待つ設定のようだ。
#param TFBFilePlayer in-file data/run000400.dat verbosity veryhigh wait 0
param TFBFilePlayer-0 in-file data/run000602.dat wait 0 max-iterations 2000
# param TFBFilePlayer-0 in-file data/run000602.dat wait 0
# <<の前に'#'を置くとコメントアウト解除
<< "#COMMENT"
param TFBFilePlayer-0 in-file data/run000400.dat verbosity veryhigh wait 0
param TFBFilePlayer-1 in-file data/run000401.dat verbosity veryhigh wait 0
param TFBFilePlayer-2 in-file data/run000402.dat verbosity veryhigh wait 0
param TFBFilePlayer-3 in-file data/run000403.dat verbosity veryhigh wait 0
param TFBFilePlayer-4 in-file data/run000404.dat verbosity veryhigh wait 0
param TFBFilePlayer-5 in-file data/run000405.dat verbosity veryhigh wait 0
#COMMENT

<< "#COMMENT"
param TFBFilePlayer-0  in-file data/run000668.dat verbosity veryhigh wait 0
param TFBFilePlayer-1  in-file data/run000669.dat verbosity veryhigh wait 0
param TFBFilePlayer-2  in-file data/run000670.dat verbosity veryhigh wait 0
param TFBFilePlayer-3  in-file data/run000671.dat verbosity veryhigh wait 0
param TFBFilePlayer-4  in-file data/run000672.dat verbosity veryhigh wait 0
param TFBFilePlayer-5  in-file data/run000673.dat verbosity veryhigh wait 0
param TFBFilePlayer-6  in-file data/run000674.dat verbosity veryhigh wait 0
param TFBFilePlayer-7  in-file data/run000675.dat verbosity veryhigh wait 0
param TFBFilePlayer-8  in-file data/run000676.dat verbosity veryhigh wait 0
param TFBFilePlayer-9  in-file data/run000677.dat verbosity veryhigh wait 0
param TFBFilePlayer-10 in-file data/run000678.dat verbosity veryhigh wait 0
param TFBFilePlayer-11 in-file data/run000679.dat verbosity veryhigh wait 0
param TFBFilePlayer-12 in-file data/run000680.dat verbosity veryhigh wait 0
param TFBFilePlayer-13 in-file data/run000681.dat verbosity veryhigh wait 0
param TFBFilePlayer-14 in-file data/run000682.dat verbosity veryhigh wait 0
param TFBFilePlayer-15 in-file data/run000683.dat verbosity veryhigh wait 0
param TFBFilePlayer-16 in-file data/run000684.dat verbosity veryhigh wait 0
param TFBFilePlayer-17 in-file data/run000685.dat verbosity veryhigh wait 0
param TFBFilePlayer-18 in-file data/run000686.dat verbosity veryhigh wait 0
param TFBFilePlayer-19 in-file data/run000687.dat verbosity veryhigh wait 0
#COMMENT

# 注意 TFSのtime-offsetは4 ns単位で書かれています。LogicFilterのLUTに合わせる思想だと思います。
param TimeFrameSlicerByLogicTiming  time-offset-begin  "-250"  time-offset-end "250"

param FileSink multipart true openmode append prefix /home/nestdaq/kashima/run/FILESINK ext .dat
# param FileSink multipart true openmode append prefix /dev/null ext .dat

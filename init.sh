#!/bin/bash
export PATH="$NESTDAQ/bin:$PATH"

pkill daq-webctl
echo "[init.sh] Killed daq-webctl processes"
sleep 0.2

echo "[init.sh] Starting Redis server with TimeSeries module..."
redis-server $NESTDAQ/etc/redis/redis.conf --loadmodule $NESTDAQ/lib64/redis/modules/redistimeseries.so --port 5921 &

# $HOME/nestdaq/bin/daq-webctl --http-uri http://0.0.0.0:5920 --redis-uri tcp://127.0.0.1:5921  >& /dev/null &
echo "[init.sh] Starting daq-webctl..."
$NESTDAQ/bin/daq-webctl \
  --http-uri http://0.0.0.0:5920 \
  --redis-uri tcp://127.0.0.1:5921 \
  # >& /dev/null &
 # 2>&1 | tee ~/kashima/run/webctl_log/daq-webctl_$(date +%Y%m%d_%H%M%S).log &
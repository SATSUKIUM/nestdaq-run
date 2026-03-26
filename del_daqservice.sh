#!/bin/bash
redis-cli -n 0 keys 'daq_service:*' | xargs redis-cli del
#redis-cli -u redis://127.0.0.1:6379 flushall                           
#redis-cli -u redis://127.0.0.1:6379/0 flushdb                          
#redis-cli -u redis://127.0.0.1:6379/1 flushdb                          
redis-cli -u redis://127.0.0.1:5921/0 flushdb 

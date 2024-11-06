#!/bin/bash
# Monitor memory usage and kill processes exceeding 24 GB

while true; do
    # Find processes using more than 24 GB of RAM (rss column)
    for pid in $(ps -eo pid,rss --no-headers | awk '$2 > 25165824 {print $1}'); do
        echo "Killing process $pid for exceeding memory limit."
        kill -9 $pid
    done
    sleep 10
done

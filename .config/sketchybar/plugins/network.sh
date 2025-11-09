#!/bin/bash

# Get network statistics
INTERFACE=$(route get default | grep interface | awk '{print $2}')
RX_BYTES=$(netstat -b -I $INTERFACE | grep -v "-" | awk '{sum += $7} END {print sum}')
TX_BYTES=$(netstat -b -I $INTERFACE | grep -v "-" | awk '{sum += $10} END {print sum}')

# Convert to human readable format
function format_bytes {
    local bytes=$1
    if [ $bytes -ge 1000000000 ]; then
        echo "$(echo "scale=1; $bytes / 1000000000" | bc)GB"
    elif [ $bytes -ge 1000000 ]; then
        echo "$(echo "scale=1; $bytes / 1000000" | bc)MB"
    elif [ $bytes -ge 1000 ]; then
        echo "$(echo "scale=1; $bytes / 1000" | bc)KB"
    else
        echo "${bytes}B"
    fi
}

RX_FORMATTED=$(format_bytes $RX_BYTES)
TX_FORMATTED=$(format_bytes $TX_BYTES)

sketchybar --set network label="↓$RX_FORMATTED ↑$TX_FORMATTED"

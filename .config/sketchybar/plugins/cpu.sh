#!/bin/bash

CPU_PERCENT=$(top -l 1 | grep "CPU usage" | awk '{print int($3)}')
sketchybar --set cpu label="$CPU_PERCENT%"

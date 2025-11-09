#!/bin/bash

MEMORY_PERCENT=$(memory_pressure | grep "System-wide memory free percentage:" | awk '{print 100 - $5}' | cut -d',' -f1)
sketchybar --set memory label="$MEMORY_PERCENT%"

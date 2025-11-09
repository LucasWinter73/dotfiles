#!/bin/bash

DISK_USAGE=$(df -h / | grep / | awk '{print $5}' | sed 's/%//')
sketchybar --set disk label="$DISK_USAGE%"

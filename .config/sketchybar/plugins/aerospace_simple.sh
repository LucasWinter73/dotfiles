#!/bin/bash

WORKSPACE_ID="$1"

# Get current focused workspace
FOCUSED_WORKSPACE=$(aerospace list-workspaces --focused)

if [ "$WORKSPACE_ID" = "$FOCUSED_WORKSPACE" ]; then
  # This workspace is focused - highlight it
  sketchybar --set space.$WORKSPACE_ID \
    background.color=0xff00d4ff \
    icon.color=0xff000000 \
    label.color=0xff000000
else
  # This workspace is not focused - normal appearance
  sketchybar --set space.$WORKSPACE_ID \
    background.color=0x44ffffff \
    icon.color=0xffffffff \
    label.color=0xffffffff
fi

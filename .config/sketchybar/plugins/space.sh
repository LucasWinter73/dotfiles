#!/bin/bash
# $PLUGIN_DIR/aerospace_monitor.sh

CURRENT_SPACE=$(aerospace --list-workspaces --focused | grep -o '[0-9]\+' | head -1)
LAST_SPACE_FILE="/tmp/aerospace_last_space"

# Read last known space
if [ -f "$LAST_SPACE_FILE" ]; then
    LAST_SPACE=$(cat "$LAST_SPACE_FILE")
else
    LAST_SPACE=""
fi

# If space changed, update SketchyBar
if [ "$CURRENT_SPACE" != "$LAST_SPACE" ]; then
    echo "$CURRENT_SPACE" > "$LAST_SPACE_FILE"
    sketchybar --trigger aerospace_workspace_changed
fi

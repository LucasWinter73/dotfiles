#!/bin/bash

# Enhanced network graph with multi-character sparkline and network info

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"
HISTORY_FILE="$PLUGIN_DIR/network_history.txt"

# Initialize history file
if [ ! -f "$HISTORY_FILE" ]; then
    touch "$HISTORY_FILE"
fi

# Get network bytes (macOS specific)
get_network_bytes() {
    INTERFACE=$(route get default 2>/dev/null | grep interface | awk '{print $2}')
    if [ -z "$INTERFACE" ]; then
        INTERFACE="en0"
    fi
    
    NETSTAT_OUTPUT=$(netstat -b -I $INTERFACE 2>/dev/null | grep -v "-" | tail -1)
    RX_BYTES=$(echo "$NETSTAT_OUTPUT" | awk '{print $7}')
    TX_BYTES=$(echo "$NETSTAT_OUTPUT" | awk '{print $10}')
    
    echo "$RX_BYTES $TX_BYTES $INTERFACE"
}

# Get IP address information
get_ip_info() {
    local interface=$1
    
    # Get local IP
    LOCAL_IP=$(ipconfig getifaddr $interface 2>/dev/null)
    if [ -z "$LOCAL_IP" ]; then
        LOCAL_IP="No IP"
    fi
    
    # Get public IP and country
    PUBLIC_IP=$(curl -s --max-time 2 https://ipinfo.io/ip 2>/dev/null)
    if [ -z "$PUBLIC_IP" ]; then
        PUBLIC_IP="No Internet"
        COUNTRY="ZA"
    else
        COUNTRY=$(curl -s --max-time 2 https://ipinfo.io/country 2>/dev/null)
        # If country is empty, longer than 3 chars, or contains non-letter characters, default to ZA
        if [ -z "$COUNTRY" ] || [ ${#COUNTRY} -gt 3 ] || [[ ! "$COUNTRY" =~ ^[A-Za-z]+$ ]]; then
            COUNTRY="ZA"
        fi
    fi
    
    echo "$LOCAL_IP|$PUBLIC_IP|$COUNTRY"
}

# Get MAC address
get_mac_address() {
    local interface=$1
    MAC_ADDRESS=$(ifconfig $interface 2>/dev/null | grep "ether" | awk '{print $2}')
    if [ -z "$MAC_ADDRESS" ]; then
        MAC_ADDRESS="00:00:00:00:00:00"
    else
        # Shorten MAC address (first 8 chars)
        MAC_SHORT=$(echo $MAC_ADDRESS | cut -c1-8)
    fi
    echo $MAC_SHORT
}

# Get network status and type
get_network_status() {
    local interface=$1
    
    # Check if WiFi or Ethernet
    if [[ $interface == "en"* ]]; then
        # Check if it's WiFi
        AIRPORT_INFO=$(/System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport -I 2>/dev/null)
        if [ -n "$AIRPORT_INFO" ]; then
            NETWORK_TYPE="WiFi"
            SSID=$(echo "$AIRPORT_INFO" | grep " SSID" | awk -F': ' '{print $2}')
            if [ -n "$SSID" ]; then
                NETWORK_TYPE="WiFi:$SSID"
            fi
        else
            NETWORK_TYPE="Ethernet"
        fi
    else
        NETWORK_TYPE="Unknown"
    fi
    
    # Check connection status
    if ifconfig $interface 2>/dev/null | grep "status: active" > /dev/null; then
        STATUS="Up"
    else
        STATUS="Down"
    fi
    
    echo "$NETWORK_TYPE|$STATUS"
}

# Calculate usage in KB/s
calculate_usage() {
    local current_rx=$1
    local current_tx=$2
    local last_rx=$3
    local last_tx=$4
    
    local rx_diff=$((current_rx - last_rx))
    local tx_diff=$((current_tx - last_tx))
    local total_diff=$((rx_diff + tx_diff))
    local usage_kbs=$((total_diff / 1024))
    
    echo $usage_kbs
}

# Create multi-character sparkline
create_sparkline() {
    local history_file="$1"
    
    if [ ! -s "$history_file" ]; then
        echo "▁▁▁▁▁"
        return
    fi
    
    # Read last 5 values
    values=($(tail -5 "$history_file"))
    
    # Find max value for scaling
    max=1000
    for value in "${values[@]}"; do
        if [ $value -gt $max ]; then
            max=$value
        fi
    done
    
    # Ensure max is at least 1 to avoid division by zero
    if [ $max -eq 0 ]; then
        max=1
    fi
    
    sparkline=""
    for value in "${values[@]}"; do
        # Scale value to 0-7 for 8-level sparkline
        level=$(( (value * 7) / max ))
        
        case $level in
            0) sparkline="${sparkline}▁" ;;
            1) sparkline="${sparkline}▂" ;;
            2) sparkline="${sparkline}▃" ;;
            3) sparkline="${sparkline}▄" ;;
            4) sparkline="${sparkline}▅" ;;
            5) sparkline="${sparkline}▆" ;;
            6) sparkline="${sparkline}▇" ;;
            7) sparkline="${sparkline}█" ;;
            *) sparkline="${sparkline}▁" ;;
        esac
    done
    
    echo "$sparkline"
}

# Format the network information string
format_network_info() {
    local local_ip=$1
    local public_ip=$2
    local country=$3
    local mac=$4
    local network_type=$5
    local status=$6
    
    # Build the info string with | separators and spaces
    info_string=""
    
    # Add local IP (full address)
    if [ "$local_ip" != "No IP" ]; then
        info_string="$local_ip"
    else
        info_string="No IP"
    fi
    
    # Add country code with spaces around separator
    info_string="${info_string} | ${country}"
    
    # Add MAC short with spaces around separator
    info_string="${info_string} | ${mac}"
    
    # Add network type (shortened) with spaces around separator
    if [[ $network_type == WiFi* ]]; then
        NET_SHORT="WiFi"
    elif [[ $network_type == Ethernet* ]]; then
        NET_SHORT="Eth"
    else
        NET_SHORT="Unknown"
    fi
    info_string="${info_string} | ${NET_SHORT}"
    
    # Add status with spaces around separator
    if [ "$status" = "Up" ]; then
        info_string="${info_string} | Up"
    else
        info_string="${info_string} | Down"
    fi
    
    echo "$info_string"
}

# Main execution
current_stats=$(get_network_bytes)
current_rx=$(echo $current_stats | awk '{print $1}')
current_tx=$(echo $current_stats | awk '{print $2}')
INTERFACE=$(echo $current_stats | awk '{print $3}')

# Get network information
ip_info=$(get_ip_info $INTERFACE)
LOCAL_IP=$(echo $ip_info | cut -d'|' -f1)
PUBLIC_IP=$(echo $ip_info | cut -d'|' -f2)
COUNTRY=$(echo $ip_info | cut -d'|' -f3)

MAC_ADDRESS=$(get_mac_address $INTERFACE)
network_status=$(get_network_status $INTERFACE)
NETWORK_TYPE=$(echo $network_status | cut -d'|' -f1)
STATUS=$(echo $network_status | cut -d'|' -f2)

# Format the complete network info
NETWORK_INFO=$(format_network_info "$LOCAL_IP" "$PUBLIC_IP" "$COUNTRY" "$MAC_ADDRESS" "$NETWORK_TYPE" "$STATUS")

# Read last stats from temp file
LAST_STATS_FILE="$PLUGIN_DIR/last_network_stats.txt"
if [ -f "$LAST_STATS_FILE" ]; then
    last_stats=$(cat "$LAST_STATS_FILE")
    last_rx=$(echo $last_stats | awk '{print $1}')
    last_tx=$(echo $last_stats | awk '{print $2}')
else
    last_rx=$current_rx
    last_tx=$current_tx
fi

# Calculate and store current usage
current_usage=$(calculate_usage $current_rx $current_tx $last_rx $last_tx)
echo "$current_usage" >> "$HISTORY_FILE"

# Keep only last 10 entries
tail -10 "$HISTORY_FILE" > "${HISTORY_FILE}.tmp" && mv "${HISTORY_FILE}.tmp" "$HISTORY_FILE"

# Create sparkline
sparkline=$(create_sparkline "$HISTORY_FILE")

# Save current stats for next run
echo "$current_rx $current_tx" > "$LAST_STATS_FILE"

# Update sketchybar with color separation
# Graph in green, text in white
sketchybar --set network_graph \
    label="$sparkline | $NETWORK_INFO" \
    drawing=on \
    label.color=0xffffffff \
    icon=""

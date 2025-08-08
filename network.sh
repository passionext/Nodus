#!/bin/bash

# This function checks if a command exists on the system.
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# --- Pre-computation Checks ---
for cmd in ss curl ping; do
  if ! command_exists $cmd; then
    echo "Error: command '$cmd' not found. Please install it to run this script." >&2
    exit 1
  fi
done

# --- 1. Gather RAW Data ---
private_ip=$(hostname -I | awk '{print $1}')
public_ip=$(curl -s --max-time 5 ifconfig.me)

# Get latency as a number, or the text "null" if it fails.
latency_val=$(ping -c 1 8.8.8.8 | grep 'time=' | awk -F'time=' '{print $2}' | awk '{print $1}') || latency_val="null"

# Get a raw, newline-separated list of open ports.
open_ports_data=$(ss -tuln | awk 'NR>1 {split($5, a, ":"); print a[length(a)]}' | sort -n | uniq)


# --- 2. Format the Open Ports into a JSON Array String ---
# This part manually builds the string "[port1,port2,port3]"
ports_json_array="["
first_port=true
# Read each line from the raw port data
while IFS= read -r port; do
  if [ -n "$port" ]; then # Ensure the line is not empty
    if [ "$first_port" = true ]; then
      ports_json_array+="$port"
      first_port=false
    else
      ports_json_array+=",$port"
    fi
  fi
done <<< "$open_ports_data"
ports_json_array+="]"


# --- 3. Build Final JSON with echo ---
# This manually constructs the final JSON string, avoiding jq.
echo "{\"private_ip\":\"${private_ip}\", \
\"public_ip\":\"${public_ip}\", \
\"latency_ms\":${latency_val}, \
\"open_ports\":${ports_json_array}}"

# Explicitly exit with a success code to ensure the Python server doesn't see an error.
exit 0



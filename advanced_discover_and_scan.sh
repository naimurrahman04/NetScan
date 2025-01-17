#!/bin/bash

# Advanced Host Discovery and Scanning Script

# Prompt for base IP if not provided
if [ -z "$1" ]; then
    echo -n "Enter the base IP address (e.g., 192.168.0): "
    read -r base_ip
else
    base_ip=$1
fi

# Validate the input
if [[ ! $base_ip =~ ^[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    echo "Invalid IP format! Please use the format: 192.168.0"
    exit 1
fi

# Files for logging
discovery_log="live_hosts.log"
scan_summary="scan_summary.log"

# Initialize logs
echo "Starting host discovery and scanning on $base_ip.0/24" > "$discovery_log"
echo "Scan Summary for $base_ip.0/24" > "$scan_summary"
echo "==============================" >> "$scan_summary"

# Discover live hosts
echo "Discovering live hosts in $base_ip.0/24..."
live_hosts=()
for ip in {1..254}; do
    (
        target="$base_ip.$ip"
        if ping -c 1 -W 1 "$target" &> /dev/null; then
            echo "$target is up"
            echo "$target" >> "$discovery_log"
            live_hosts+=("$target")
        fi
    ) &
done
wait

# Check if any hosts are alive
if [ ! -s "$discovery_log" ]; then
    echo "No live hosts found. Exiting."
    exit 1
fi

# Scan live hosts
echo "Scanning live hosts..."
while IFS= read -r ip; do
    output_file="${ip}.txt"
    if [ -f "$output_file" ]; then
        echo "Scan result for $ip already exists in $output_file."
        echo "Options: [v]iew, [d]elete and rescan, [s]kip"
        read -n 1 -r choice
        echo
        case $choice in
            v|V)
                echo "Displaying existing results for $ip:"
                cat "$output_file"
                echo
                ;;
            d|D)
                echo "Deleting $output_file and rescanning $ip..."
                rm "$output_file"
                echo "Results for $ip:" > "$output_file"
                sudo nmap -T4 -A -p- -O "$ip" >> "$output_file"
                echo "$ip scan results saved in $output_file."
                ;;
            s|S)
                echo "Skipping $ip."
                ;;
            *)
                echo "Invalid option. Skipping $ip."
                ;;
        esac
    else
        echo "Scanning $ip..."
        echo "Results for $ip:" > "$output_file"
        sudo nmap -T4 -A -p- -O "$ip" >> "$output_file"
        echo "$ip scan results saved in $output_file."
    fi
    echo "$ip - Results saved in $output_file" >> "$scan_summary"
done < "$discovery_log"

# Completion message
echo "Discovery and scanning complete. Summary saved in $scan_summary."
echo "Detailed scan results are stored in individual files named [IP].txt."

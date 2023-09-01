#!/bin/bash

# Function to check if Google can be pinged
check_ping() {
    ping -c 1 1.1.1.1 > /dev/null 2>&1
    return $?
}

# Loop until Google can be pinged successfully
echo "Waiting for Google to respond to ping..."
while ! check_ping; do
    sleep 1
done

# Define the network interface you want to check for
network_interface="wg0"  # Replace with the name of your interface

# Check if the network interface exists
if [[ -e "/sys/class/net/$network_interface" ]]; then
    echo "Network interface $network_interface exists."
else
    echo "Network interface $network_interface does not exist. Running a command..."
    /usr/bin/connmanctl connect vpn_name
fi

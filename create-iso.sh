#!/bin/bash

# Check if genisoimage is installed
if ! command -v genisoimage >/dev/null 2>&1; then
    echo "genisoimage not found. Please install it and try again."
    exit 1
fi

# Prompt for hostname, last octet, and user password
read -p "Enter hostname: " hostname
read -p "Enter last octet: " octet
read -s -p "Enter user password: " password

# Check if any required variable is empty
if [[ -z "$hostname" || -z "$octet" || -z "$password" ]]; then
    echo "Error: hostname, octet, and password cannot be empty." >&2
    exit 1
fi

# Hash password and replace placeholders in files
password=$(openssl passwd -6 $password)
sed -i "s|todo_hostname|${hostname}|g" meta-data
sed -i "s|todo_hostname|${hostname}|g" user-data
sed -i "s|todo_passwd|${password}|g" user-data
sed -i "s|todo_octet|${octet}|g" network-config

# create ISO
genisoimage \
    -output $hostname.iso -input-charset utf-8 \
    -volid cidata -rational-rock -joliet \
    user-data meta-data network-config

echo "$hostname.iso created successfully."


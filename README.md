# cloud-init image generator
This repo contains a shell script and three yaml files with cloud-init data.

## Requirements
You must have `genisoimage` installed to generate an ISO file containing the cloud-init data. This file can be mounted as a CD when using a cloud image.

## How to use
- Execute `create-iso.sh`. It will prompt you for two variables: *hostname* and *octet*.
- The script will replace the string "todo_hostname" and "todo_octet" where they appear in the files. *octet* refers to the last octet in an IP address that starts with "192.168.128." and a CIDR range of /23.


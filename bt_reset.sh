#!/usr/bin/env bash

# Remove all connected external devices
for device in $(bluetoothctl devices | grep -o "[[:xdigit:]:]\{8,17\}"); do
    echo $(bluetoothctl remove $device)
done

# Re-insert into kernel
modprobe -r btusb
modprobe btusb

# Re-enable device itself
rfkill block bluetooth
rfkill unblock bluetooth

# Restart service
systemctl restart bluetooth
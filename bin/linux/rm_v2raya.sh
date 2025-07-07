#!/bin/bash

rm sudo rm /etc/apt/sources.list.d/v2raya.list
sudo apt remove --purge v2raya
sudo apt autoremove
sudo apt autoclean

if dpkg -l | grep v2raya; then
    echo "V2RayA related packages still found."
else
    echo "V2RayA has been completely removed."
fi

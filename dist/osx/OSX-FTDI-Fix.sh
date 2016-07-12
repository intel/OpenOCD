#!/bin/bash

######
# OS X comes preloaded with an FTDI-VCP driver.
# In order to use Flyswatter (FTDI-D2XX device), a user must
# 1. Install FTDI-D2XX driver: http://www.ftdichip.com/Drivers/D2XX.htm
# 2. Unload  FTDI-VCP driver
# This script unloads FTDI-VCP driver.
#
# Each unload attempt first tries to load then unload, because
# sometimes the unload fails because it's incorrectly loaded initially.
#
# References:
#   http://pylibftdi.readthedocs.io/en/latest/troubleshooting.html
#   http://koblents.com/Ches/Original-Work/171-Unloading-FTDI-drivers-on-a-Mac-for-libftdi/
######

# Fail if not root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Legacy driver
kextload   -b com.FTDI.driver.FTDIUSBSerialDriver &> /dev/null
kextunload -b com.FTDI.driver.FTDIUSBSerialDriver &> /dev/null

# Mountain Lion (10.8), or earlier
kextload   -b com.apple.driver.AppleUSBFTDI &> /dev/null
kextunload -b com.apple.driver.AppleUSBFTDI &> /dev/null

# Mavericks (10.9), Yosemite (10.10), or later
kextload   /System/Library/Extensions/FTDIUSBSerialDriver.kext &> /dev/null
kextunload /System/Library/Extensions/FTDIUSBSerialDriver.kext &> /dev/null

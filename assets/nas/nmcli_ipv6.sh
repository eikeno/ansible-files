#!/bin/bash
# enable :
sudo nmcli con mod "Wired connection 2" ipv6.addr-gen-mode "stable-privacy"
sudo nmcli con mod "Wired connection 2" ipv6.method auto

# disable :
 sudo nmcli con mod "Wired connection 2" ipv6.method "disabled"
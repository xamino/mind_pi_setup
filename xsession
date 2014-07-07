#!/bin/bash

xset s off
xset -dpms
xset s noblank

iceweasel -width 1920 -height 1080 'http://134.60.70.249/public_display_start.jsp'
exec matchbox-window-manager -use_titlebar no


#!/bin/sh
killall conky
cd /home/kd9yqk/.config/conky/
/usr/local/bin/conky -c system.rc 2> /dev/null
/usr/local/bin/conky -c radio.rc
/usr/local/bin/conky -c location.rc
/usr/local/bin/conky -c processes.rc
/usr/local/bin/conky -c direwolf.rc
/usr/local/bin/conky -c pat.rc

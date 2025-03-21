#!/bin/sh
killall conky
cd /home/kd9yqk/ham314/conky/
conky -c system.rc 2> /dev/null
conky -c radio.rc
conky -c location.rc
conky -c processes.rc
conky -c direwolf.rc
conky -c pat.rc

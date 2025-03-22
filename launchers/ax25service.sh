#!/bin/bash -x
# trap ctrl-c and call ctrl_c()
trap ctrl_c INT
trap ctrl_c TERM
function ctrl_c() {
   sudo nodesave /etc/ax25/nodebackup.sh
   sudo killall mheardd
   sudo killall ax25d
   sudo killall kissattach
   sudo killall direwolf
   exit 0
}

sudo killall mheardd
sudo killall ax25d
sudo killall kissattach
sudo killall direwolf

# zero out old direwolf log file in case /tmp/ is full
truncate --size 0 /tmp/direwolf.log

#echo "Starting direwolf"
sudo -u kd9yqk direwolf -t 0 -c /home/kd9yqk/direwolf-node.conf -p > /tmp/direwolf.log &

#Check if Direwolf is running
#echo "Sleeping 5 sec."
sleep 5
if [ -z "`ps ax | grep -v grep | grep direwolf`" ]; then
  #echo -e "\nERROR: Direwolf did not start properly and is not running, please review direwolf.conf"
  exit 1
fi

sudo modprobe netrom
nrdevice=`ifconfig | grep nr0 | wc -l`
if [ $nrdevice -eq 0 ]; then
  sudo nrattach netrom  # run this once per boot
fi

sudo kissattach `ls -l /tmp/kisstnc | awk '{ print $11 }'` ax0

sudo kissparms -c 1 -p ax0  # fix invalid port first to tries on direwolf
sudo ax25d  # for rmsgw only
sudo /etc/ax25/nodebackup.sh  # restore node table and routes we heard last time
sudo /usr/sbin/netromd        # Start the netrom service, lists for nodes/routes
sudo mheardd
#sudo route del -net 44.0.0.0 netmask 255.0.0.0  # kill tcp traffic to ax0, updatesysop.py hits api.winlink.org on net 44

# backup node data hourly
while true; do
   sleep 1200
   sudo nodesave /etc/ax25/nodebackup.sh
done

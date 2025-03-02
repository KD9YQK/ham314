echo 'Backing up node'
sudo nodesave /etc/ax25/nodebackup.sh
echo 'Closing mheardd'
sudo killall mheardd
echo 'Closing ax25d'
sudo killall ax25d
echo 'closing kissattach'
sudo killall kissattach
echo 'Closing direwolf'
sudo killall direwolf
echo 'Closing netromd'
sudo killall netromd
ifconfig nr0 down
echo 'Shutdown complete'

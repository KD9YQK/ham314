echo "Install AX.25 Packet Node"
sleep 1
sudo apt install gpsd libgps28 -y
#sudo dpkg -i ../deb/direwolf*.deb
#sudo dpkg -i ../deb/libax25_1*.deb
#sudo dpkg -i ../deb/libax25-dev*.deb
#sudo dpkg -i ../deb/ax25apps*.deb
#sudo dpkg -i ../deb/ax25tools*.deb
#sudo dpkg -i ../deb/uronode_*.deb
#sudo apt-get install ax25-tools ax25-apps telnet ax25-node -y
#sudo apt install uronode openbsd-inetd tcpd -y
sudo apt install telnet openbsd-inetd tcpd -y
sudo cp ../conf/ax25/* /etc/ax25
sudo touch /etc/ax25/nodebackup.sh
sudo chmod u+x /etc/ax25/nodebackup.sh
cp ../conf/direwolf/direwolf-node.conf ~/
sudo echo "uronode       4444/tcp        # KD9YQK packet node" | sudo tee -a /etc/services
sudo echo "uronode stream tcp nowait root /usr/sbin/uronode uronode" | sudo tee -a /etc/inetd.conf
sudo service inetd restart

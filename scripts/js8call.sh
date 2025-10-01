echo 'Build js8call 2.2.0'
sleep 1
#sudo apt install js8call -y
cd ~/build
sudo apt-get build-dep js8call
sudo apt remove libhamlib4 # Required to use compiled hamlib
wget http://files.js8call.com/2.2.0/js8call-2.2.0.tgz
tar -zxvf js8call-2.2.0.tgz
cd js8call
cmake ~/build/js8call
make -j 4
sudo make install

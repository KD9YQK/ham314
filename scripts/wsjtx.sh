echo 'Install WSJT-X'
sleep 1
#sudo apt install wsjtx -y
#cd ~/build
sudo apt install libgfortran5 libqt5widgets5 libqt5network5 \
     libqt5printsupport5 libqt5multimedia5-plugins libqt5serialport5 \
     libqt5sql5-sqlite libfftw3-single3 libgomp1 libboost-all-dev \
     libusb-1.0-0 libportaudio2 -y
wget https://sourceforge.net/projects/wsjt/files/wsjtx-2.7.0/wsjtx_2.7.0_armhf.deb
sudo dpkg -i wsjtx_2.7.0_armhf.deb -y
sudo apt --fix-broken install -y

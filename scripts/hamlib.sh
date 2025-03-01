echo 'Building Hamlib 4.6.2'
cd ~/build
sudo apt-get update
sudo apt-get install libfltk1.3-dev libjpeg9-dev libxft-dev libxinerama-dev libxcursor-dev libsndfile1-dev libsamplerate0-dev portaudio19-dev libusb-1.0-0-dev libpulse-dev libudev-dev texinfo -y
sudo apt-get install -y libjpeg62-turbo-dev
wget https://github.com/Hamlib/Hamlib/releases/download/4.6.2/hamlib-4.6.2.tar.gz
tar -zxvf hamlib-4.6.2.tar.gz
cd hamlib-4.6.2
./configure --prefix=/usr/local --enable-static
make -j 4
make check
sudo apt install checkinstall
#sudo make install
sudo checkinstall
sudo ldconfig

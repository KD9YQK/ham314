echo 'Building Hamlib 4.6.5'
cd ~/build
sudo apt-get update
sudo apt-get install libfltk1.3-dev libjpeg9-dev libxft-dev libxinerama-dev libxcursor-dev libsndfile1-dev libsamplerate0-dev portaudio19-dev libusb-1.0-0-dev libpulse-dev libudev-dev texinfo -y
sudo apt-get install -y libjpeg62-turbo-dev
wget https://github.com/Hamlib/Hamlib/releases/download/4.6.5/hamlib-4.6.5.tar.gz
tar -zxvf hamlib-4.6.5.tar.gz
cd hamlib-4.6.5
./configure
#./configure --disable-shared --prefix="/usr/local" --without-cxx-binding \
#    --disable-winradio CFLAGS="-fdata-sections -ffunction-sections" \
#    LDFLAGS="-Wl,--gc-sections" LIBUSB_LIBS="/usr/lib/arm-linux-gnueabihf/libusb-1.0.a"
echo "Configure complete, Make in 5 seconds"
sleep 5
make -j 4
echo "Make complete, Check in 5 seconds"
sleep 5
make check
echo "Check complete, Install in 5 seconds"
sleep 5
sudo make install
#sudo apt install checkinstall
#sudo checkinstall
sudo ldconfig

echo 'Building Fldigi 4.2.04'
cd ~/build
wget https://www.w1hkj.org/files/fldigi/fldigi-4.2.06.tar.gz
tar -zxvf fldigi-4.2.06.tar.gz
cd fldigi-4.2.06
./configure --prefix=/usr/local --enable-static
make -j 4
sudo make install

echo "Install AX.25"
cd ~/build
sudo apt -y install build-essential autoconf automake libtool checkinstall git cmake
sudo apt -y install libtool dpkg-dev debhelper devscripts fakeroot lintian dh-make config-package-dev dh-exec
sudo apt -y install zlib1g zlib1g-dev
git clone https://github.com/ve7fet/linuxax25.git
cd linuxax25

echo "Build libax25"
cd libax25
./autogen.sh
NUMCPUS=`lscpu | grep CPU\(s\): | awk '{print $2}'`
echo -e "Compiling on $NUMCPUS CPUs concurrently\n"
debuild -us -uc -j$NUMCPUS
cd ..
sudo dpkg -i libax25_*_*.deb
sudo dpkg -i libax25-dev_*_*.deb
sudo apt-mark hold libax25

echo "Build ax25apps"
sudo apt -y install libncursesw5 libncursesw5-dev
cd ax25apps
./autogen.sh
NUMCPUS=`lscpu | grep CPU\(s\): | awk '{print $2}'`
echo -e "Compiling on $NUMCPUS CPUs concurrently\n"
debuild -us -uc -j$NUMCPUS
cd ..
sudo dpkg -i ax25apps_*_*.deb
sudo apt-mark hold ax25apps

echo "Build ax25-tools"
cd ax25tools
./autogen.sh
NUMCPUS=`lscpu | grep CPU\(s\): | awk '{print $2}'`
echo -e "Compiling on $NUMCPUS CPUs concurrently\n"
debuild -us -uc -j$NUMCPUS
cd ..
sudo dpkg -i ax25tools_*_*.deb
sudo apt-mark hold ax25tools

echo "Build uronode"
cd ~/build
mkdir uronode
cd uronode
wget https://downloads.sourceforge.net/project/uronode/uronode-2.15.tar.gz
tar xzvf uronode-2.15.tar.gz
wget http://deb.debian.org/debian/pool/main/u/uronode/uronode_2.15-5.debian.tar.xz
cp uronode-2.15.tar.gz uronode_2.15.orig.tar.gz
cd uronode-2.15
tar xJvf ../uronode_2.15-5.debian.tar.xz
NUMCPUS=`lscpu | grep CPU\(s\): | awk '{print $2}'`
echo -e "Compiling on $NUMCPUS CPUs concurrently\n"
debuild -us -uc -j$NUMCPUS
cd ..
sudo dpkg -i uronode_2.15-*.deb
sudo apt-mark hold uronode
cd ..

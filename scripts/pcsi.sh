echo 'Build PCSI'
sudo apt-get install libopenblas-dev
cd ~
git clone https://github.com/maqifrnswa/PCSI.git
python -m venv --system-site-packages PCSI/
#sudo apt install python3-opencv python3-tk python3-pil.imagetk -y
sudo apt install python3-opencv
PCSI/bin/pip install numpy==2.0.2 imageio bitstring==4.1.4 pylbfgs pyserial pillow


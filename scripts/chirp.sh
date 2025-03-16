echo 'Install Chirp'
cd ~/build
sudo apt install git python3-wxgtk4.0 python3-serial python3-six python3-future python3-requests python3-pip pipx -y
wget https://archive.chirpmyradio.com/chirp_next/next-20250314/chirp-20250314-py3-none-any.whl
pipx install --system-site-packages ./chirp-20250314-py3-none-any.whl

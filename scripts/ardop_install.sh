# Download and install ardopc (URL is for the Raspberry Pi version)
wget 'http://www.cantab.net/users/john.wiseman/Downloads/Beta/piardopc64' -O /tmp/ardopc
sudo mv /tmp/ardopc /usr/local/bin/
sudo chmod +x /usr/local/bin/ardopc
# Find the correct sound card identifier (See video tutorial and John Wiseman's comments)
aplay -l



# Configure sound devices (You may need to change "plughw:1,0" depending on above aplay output)
echo 'pcm.ARDOP {type rate slave {pcm "plughw:3,0" rate 48000}}' > ~/.asoundrc

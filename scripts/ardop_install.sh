sudo CP apps/ardop/ardopc /usr/local/bin/
sudo chmod +x /usr/local/bin/ardopc

# Find the correct sound card identifier (See video tutorial and John Wiseman's comments)
#aplay -l
# Configure sound devices (You may need to change "plughw:1,0" depending on above aplay output)
#echo 'pcm.ARDOP {type rate slave {pcm "plughw:3,0" rate 48000}}' > ~/.asoundrc

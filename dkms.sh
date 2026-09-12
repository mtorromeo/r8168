# Retry
sudo cp -r . /usr/src/r8168-8.055.00
sudo dkms add -m r8168 -v 8.055.00
sudo dkms build -m r8168 -v 8.055.00
sudo dkms install -m r8168 -v 8.055.00


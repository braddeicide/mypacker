# Zero out the free space to save space in the final image:
dd if=/dev/zero of=/EMPTY bs=1M
# this rm is often failing, not sure why, lets try sleeping..
sleep 5 
rm -f /EMPTY

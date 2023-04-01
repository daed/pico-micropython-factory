# This script is provided as a convenience to the user needing to flash
# a Pico W with the provided firmware.  This is a static script that has
# not taken any external factors into consideration.  Please verify that 
# settings below are correct before flashing!

MOUNT_DIR=`mount | grep RPI-RP2 | awk '{print $3}'`
echo trying to write to $MOUNT_DIR/firmware.uf2
cp -r project/working/firmware.uf2 $MOUNT_DIR/

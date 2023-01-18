# This script is provided as a convenience to the user needing to flash
# the ESP32 with the provided firmware.  This is a static script that has
# not taken any external factors into consideration.  Please verify that 
# settings below are correct before flashing!
sudo esptool.py --chip esp32 -p /dev/ttyUSB0 -b 460800 \
  --before=default_reset --after=hard_reset write_flash \
  --flash_mode dio --flash_freq 40m --flash_size 4MB \
  0x8000 project/working/partition-table.bin \
  0x1000 project/working/bootloader.bin \
  0x10000 project/working/micropython.bin

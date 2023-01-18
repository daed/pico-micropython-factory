# some knobs
DEBUG=0

export CURDATE=`date +%Y%m%d`
export WORKING=/project/working

echo ----------------------------------
echo     ENVIRONMENT STATUS
echo UID: ${UID} GID: ${GID}
groupadd -g $GID user
useradd -g $GID -u $UID user
echo - user created to match permissions on host
echo ----------------------------------
echo ----------------------------------
echo     BUILD STARTED!
. $IDF_PATH/export.sh
cd /micropython/ports/esp32
make
chown -R ${UID}:${GID} build-GENERIC
echo ----------------------------------
echo ----------------------------------
echo     BUILD FINISHED!
echo ----------------------------------

mkdir -p $WORKING
cp build-GENERIC/micropython.* $WORKING
cp build-GENERIC/partition_table/partition-table.bin $WORKING
cp build-GENERIC/bootloader/bootloader.bin $WORKING

cd /project
rm -rf micropython-esp32-$CURDATE.tar.gz

cd $WORKING
tar cvf /project/micropython-esp32-$CURDATE.tar *

cd /project
gzip micropython-esp32-$CURDATE.tar 
chown -R user:user /project 

echo ----------------------------------
echo    JOBS DONE
echo ----------------------------------
echo ----------------------------------

if [ $DEBUG -ne 0 ]; then
    sleep 1000000000
fi
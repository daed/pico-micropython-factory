# some knobs
DEBUG=0

export DIRBOARD="rp2"
export BUILDN="PICO_W"
export BOARD_DIR=boards/$BUILDN/
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
cd /micropython/ports/$DIRBOARD
make
chown -R ${UID}:${GID} build-$BUILDN
echo ----------------------------------
echo ----------------------------------
echo     BUILD FINISHED!
echo ----------------------------------

mkdir -p $WORKING
cp build-$BUILDN/firmware.* $WORKING

cd /project
rm -rf micropython-$DIRBOARD-$CURDATE.tar.gz

cd $WORKING
tar cvf /project/micropython-$DIRBOARD-$CURDATE.tar *

cd /project
gzip micropython-$DIRBOARD-$CURDATE.tar 
chown -R user:user /project 

echo ----------------------------------
echo    JOBS DONE
echo ----------------------------------
echo ----------------------------------

if [ $DEBUG -ne 0 ]; then
    sleep 1000000000
fi

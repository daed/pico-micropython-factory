export DO_UID=`id -u`
export DO_GID=`id -g`
docker-compose -f Docker/docker-compose.yml build
docker-compose -f Docker/docker-compose.yml up


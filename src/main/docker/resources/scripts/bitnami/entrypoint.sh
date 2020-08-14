#!/bin/bash

# shellcheck disable=SC1091

set -o errexit
set -o nounset
set -o pipefail
# set -o xtrace # Uncomment this line for debugging purposes

# Load libraries
. /opt/bitnami/scripts/liblog.sh
. /opt/bitnami/scripts/libbitnami.sh
. /opt/bitnami/scripts/libzookeeper.sh

HOST=`hostname -s`
DOMAIN=`hostname -d`
SERVER_PORT=2888
ELECTION_PORT=3888
ZOO_SERVERS=''
if [[ $HOST =~ (.*)-([0-9]+)$ ]];
then
  NAME=${BASH_REMATCH[1]}
  ORD=${BASH_REMATCH[2]}
else
  echo "FAILED to parse name and ordinal of Pod"
  exit 1
fi
ZOO_SERVER_ID=$((ORD+1))
ZOO_SERVERS=''
for (( i=1; i<=$SERVERS; i++ ))
do
  SERVER_HOST=''
  if [ $i == $ZOO_SERVER_ID ];
  then
    SERVER_HOST='0.0.0.0'
  else
    SERVER_HOST="$NAME-$((i-1)).$DOMAIN"
  fi
  ZOO_SERVERS="${ZOO_SERVERS}${ZOO_SERVERS:+,}$SERVER_HOST:$SERVER_PORT:$ELECTION_PORT"
done

# Load ZooKeeper environment variables
eval "$(zookeeper_env)"

print_welcome_page

if [[ "$*" = "/opt/bitnami/scripts/zookeeper/run.sh" || "$*" = "/run.sh" ]]; then
    info "** Starting ZooKeeper setup **"
    /opt/bitnami/scripts/zookeeper/setup.sh
    info "** ZooKeeper setup finished! **"
fi

echo ""
exec "$@"

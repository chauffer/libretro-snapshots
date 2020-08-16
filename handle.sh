#!/bin/bash
set -ex

LINK=$2
RUN=$1
DIR=$(echo $LINK | tr '/' ' ' | awk '{print $4}')
DATE=$(date +%Y_%m_%d_%H%M)
DAY=$(date +%Y_%m_%d)
TAR=${DATE}_$(echo $DIR | sed 's/.git//').tar

git clone --mirror $LINK
tar -cvf ${TAR} /data/repositories/${DIR}
rm -rf $DIR
SIZE=$(du -m $TAR | awk '{print $1}')

if [ "$SIZE" -gt "2000" ]; then
    split -b 2000m ${TAR} ${TAR}
    rm ${TAR}
fi

for i in $(ls $TAR*); do
    github-release $REPO $RUN master 'Automated backups' "${TAR}*"
    rm ${TAR}*
done

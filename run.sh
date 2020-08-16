#!/bin/bash
set -ex
mkdir -p /data/repositories
cd /data/repositories
DATE=$(date +%Y_%m_%d_%H%M)
python3 /app/repositories.py | grep -v libretro-thumbnails | xargs -P $PARALLEL -L 1 /app/handle.sh ${DATE}

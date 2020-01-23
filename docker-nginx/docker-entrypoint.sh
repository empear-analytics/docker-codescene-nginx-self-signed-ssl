#!/bin/bash

set -e

cd /opt/www/

echo ">> DOCKER-ENTRYPOINT: EXECUTING CMD"

exec "$@"

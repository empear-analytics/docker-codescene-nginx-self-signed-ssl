#!/bin/bash

set -e

echo ">> DOCKER-ENTRYPOINT: GENERATING SSL CERT"

cd /opt/ssl/
openssl genrsa -des3 -passout pass:x -out server.pass.key 2048
openssl rsa -passin pass:x -in server.pass.key -out server.key
rm server.pass.key
openssl req -new -key server.key -out server.csr -subj "/C=SE/ST=Skane/L=Malmo/O=codescene.io/OU=codescene.io/CN=local.codescene.io"
openssl x509 -req -sha256 -days 300065 -in server.csr -signkey server.key -out server.crt
cd /opt/www/

echo ">> DOCKER-ENTRYPOINT: GENERATING SSL CERT ... DONE"
echo ">> DOCKER-ENTRYPOINT: EXECUTING CMD"

exec "$@"

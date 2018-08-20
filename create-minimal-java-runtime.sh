#!/bin/sh

rm -fr target/openjdk-10-base_linux-x64

docker run --rm \
  --volume $PWD:/out \
  jdk-10-debian-slim \
  jlink --module-path /opt/jdk-10/jmods \
    --verbose \
    --add-modules java.base \
    --compress 2 \
    --no-header-files \
    --output /out/target/openjdk-10-base_linux-x64

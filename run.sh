#!/usr/bin/env bash
set -eEuo pipefail

echo "================================================================"
echo "Building docker image"
echo "================================================================"

docker build . \
    -t chatgpt \
    --build-arg HOST_UID=$UID

echo "================================================================"
echo "Starting docker container"
echo "args: $@"
echo "================================================================"

docker run \
    -it \
    --rm \
    -v ${PWD}/game:/home/user/game \
    --entrypoint /home/user/game/host.sh \
    chatgpt \
    $@

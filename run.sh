#!/usr/bin/env bash
set -eEuo pipefail

# build
docker build . \
    -t chatgpt \
    --build-arg HOST_UID=$UID

# run
docker run \
    -it \
    --rm \
    -v ${PWD}/game:/home/user/game \
    --entrypoint tty-share \
    chatgpt \
    --command /home/user/game/play.sh \
    $@

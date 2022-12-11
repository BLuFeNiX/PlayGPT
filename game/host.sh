#!/usr/bin/env bash
set -eEuo pipefail

tty-share \
	--command /home/user/game/play.sh \
    --listen "$(hostname -I | xargs):8000" \
    $@

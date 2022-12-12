#!/usr/bin/env bash
# set -eEuo pipefail

# cd to script directory
cd "$(dirname "$0")"

GAME_TITLE="#[align=centre]Welcome to GPTQuest! Join via your browser at ${TTY_SHARE_LOCAL_URL}/s/local/"
GAME_TITLE_2="#[align=centre]or ${TTY_SHARE_PUBLIC_URL:-no public URL}"

tmux new-session 'python3 play.py || tail -f' \; \
	set -g pane-border-status bottom \; \
	set -g pane-border-format '#[align=centre][ GPTQuest ]' \; \
	set -g status-position top \; \
	set -g status-bg black \; \
	set -g status-fg green \; \
	set -g status 2 \; \
	set -g status-format[0] "#[align=centre]$GAME_TITLE" \; \
	set -g status-format[1] "#[align=centre]$GAME_TITLE_2" \; \
	set -g mouse on \; \
	bind -n C-c display-message "To copy text: hold shift while highlighting, then right-click -> copy!" \; \
	unbind -n MouseDown3Pane

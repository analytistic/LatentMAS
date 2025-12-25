#!/bin/bash

SESSION_NAME='latent_medqa'
SCRIPTS=(
    "./tests/medqa/chunk1.sh"
    "./tests/medqa/chunk2.sh"
    "./tests/medqa/chunk3.sh"
    "./tests/medqa/chunk4.sh"
    "./tests/medqa/chunk5.sh"
    "./tests/medqa/chunk6.sh"
)

if tmux has-session -t $SESSION_NAME 2>/dev/null; then
    tmux kill-session -t $SESSION_NAME
fi

tmux new-session -d -s $SESSION_NAME \
    "bash ${SCRIPTS[0]}; exec bash"
tmux split-window -v -t $SESSION_NAME \
    "bash ${SCRIPTS[1]}; exec bash"
tmux split-window -v -t $SESSION_NAME \
    "bash ${SCRIPTS[2]}; exec bash"

tmux select-pane -t $SESSION_NAME:0.0
tmux split-window -h -t $SESSION_NAME \
    "bash ${SCRIPTS[3]}; exec bash"
tmux split-window -v -t $SESSION_NAME \
    "bash ${SCRIPTS[4]}; exec bash"
tmux split-window -v -t $SESSION_NAME \
    "bash ${SCRIPTS[5]}; exec bash"

tmux select-layout -t $SESSION_NAME tiled
tmux attach-session -t $SESSION_NAME
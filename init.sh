#!/bin/bash
session='angular'
PROJECT_ROOT='~/projects/nerijus-g.github.io'


pkgs='tmux docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin'
if ! dpkg -s $pkgs >/dev/null 2>&1; then

    # Add Docker's official GPG key:
    sudo apt update
    sudo apt install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc

    # Add the repository to Apt sources:
    sudo tee /etc/apt/sources.list.d/docker.sources <<EOF
Types: deb
URIs: https://download.docker.com/linux/debian
Suites: $(. /etc/os-release && echo "$VERSION_CODENAME")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF

    sudo apt update
    sudo apt-get install $pkgs
fi

tmux new-session -d -s $session

tmux rename-window -t 0 'git'
tmux send-keys -t 'git' "cd $PROJECT_ROOT" C-m

tmux new-window -t $session:1 -n 'scripts'
tmux send-keys -t 'scripts' "bash $PROJECT_ROOT/scripts/menu.sh $PROJECT_ROOT" C-m

tmux new-window -t $session:2 -n 'vscode'
tmux send-keys -t 'vscode' "cd $PROJECT_ROOT" C-m

tmux new-window -t $session:3 -n 'nodejs'
tmux send-keys -t 'nodejs' "cd $PROJECT_ROOT" C-m

tmux attach -t $session:1

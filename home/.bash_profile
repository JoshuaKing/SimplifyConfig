#!/bin/bash

# Stream Twitch to VLC
alias stream="livestreamer $1 source --hls-segment-threads 5 --player-passthrough hls"

# Use SSH with the work-from-home key
alias sshwork="ssh -i ~/.ssh/work_from_home"

# With the .m2/settings.xml profile - disable many tests, checks, and only run the bare minimum to compile and then execute
alias mvnq="mvn package -Pquick && ./start.sh"

# list-long and list-long-alphabetic - Display only useful ls data, in a presentable format (human-readable sizing, correct width columns)
listlong() {
	ls -lhPpA $1 | tr -s ' ' | cut -d' ' -f1,3,5,9 | column -t
}
alias ll=listlong

# el n = echo as output the last nth file to be used (getlast will simply set the env variables)
getlastfile() {
    LAST=$(history | egrep -o "(\s|^)~?[a-zA-Z0-9_-]*[./][./a-zA-Z0-9_-]*[^.](\s|$)" | tr -d ' ' | tail -$1 | head -1)
    export l=${LAST/#\~/$HOME}
    export LAST=$l
    export LAST$1=$l
}
alias getlast="getlastfile $1"
alias el="getlast $1; echo $l"

# source profile quickly
alias profile="source ~/.bash_profile"

if [ ! -d ~/.vim_runtime ]; then 
	git clone git://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_basic_vimrc.sh
fi

export PROMPT_COMMAND="getlast 2; getlast 1"

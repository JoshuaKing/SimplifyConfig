#!/bin/bash
localbin=~/.bin
mkdir -p $localbin

# Stream Twitch to VLC
alias stream="livestreamer $1 source --hls-segment-threads 5 --player-passthrough hls"

# Aliases for certain SSH Keys
alias sshwork="ssh -i ~/.ssh/work_from_home"
alias ewetest="ssh -i ~/.ssh/ewetest -l ec2-user"

# With the .m2/settings.xml profile - disable many tests, checks, and only run the bare minimum to compile and then execute
alias mvnq="mvn package -Pquick && ./start.sh"

# list-long and list-long-alphabetic - Display only useful ls data, in a presentable format (human-readable sizing, correct width columns)
ll() {
    if [ $# == 1 ] && [ -f $1 ]; then
        less $1 
    else
	    ls -lhPpA $@ | tr -s ' ' | cut -d' ' -f1,3,5,9 | column -t
    fi
}

# l - echo the last file to be used (getlast will simply set the env variables)
getlastfile() {
    LAST=$(history | egrep -o "(\s|^)~?[a-zA-Z0-9_-]*[./][./a-zA-Z0-9_-]*[^.](\s|$)" | tr -d ' ' | tail -$1 | head -1)
    export l=${LAST/#\~/$HOME}
    export l$1=${LAST/#\~/$HOME}
    export LAST=$l
    export LAST$1=$l
}
alias getlast="getlastfile $1"
alias l="getlast 1; echo $l"

# source profile quickly
alias profile="source ~/.bash_profile"

# run command in the background w/o output
run() {
    nohup $@ >/dev/null 2>&1 &
}

# use vim configuration if none provided 
if [ ! -f ~/.vimrc ]; then 
	git clone git://github.com/amix/vimrc.git ~/.vim_runtime
    echo "set number" > ~/.vim_runtime/my_configs.vim
    echo "colorscheme solarized" > ~/.vim_runtime/my_configs.vim
	sh ~/.vim_runtime/install_basic_vimrc.sh
    cp ~/.vim_runtime/sources_non_forked/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/ 
fi

# get jawks for json notes 
if [ ! -f $localbin/jsawk ]; then
    curl -L http://github.com/micha/jsawk/raw/master/jsawk > $localbin/jsawk
    chmod u+x $localbin/jsawk
fi

export PROMPT_COMMAND="getlast 2; getlast 1"
export PS1="\n\[$(tput bold)\]\u:\W\\$ \[$(tput sgr0)\]"

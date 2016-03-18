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

# source profile quickly
alias profile="source ~/.bash_profile"

# git add, then commit changes, then push
acp() {
    git add -A
    git status
    git commit -m "$1"
    read -p "Press Enter to push changes"
    git push
}

# quickly switch between work/home projects
alias home="cd ~/Projects"
alias work="cd ~/Work"

# alias for Notes app
#alias note="java -jar ~/.bin/Note.jar $@"
#echo "new notttteee " > ~/.vim_notes_template
#export VIM_NOTES_TEMPLATE="~/.vim_notes_template"
note() {
    filename="note:$@"
    vim "${filename}"
}
alias notes="ls ~/.vim/bundle/vim-notes/misc/notes/user/"

# run command in the background w/o output
run() {
    nohup $@ >/dev/null 2>&1 &
}

# use vim configuration if none provided 
if [ ! -f ~/.vimrc ]; then 
    git clone git://github.com/amix/vimrc.git ~/.vim_runtime
    sh ~/.vim_runtime/install_awesome_vimrc.sh

    # Solarized Colorscheme
    #mkdir -p ~/.vim/colors/
    #cp ~/.vim_runtime/sources_non_forked/vim-colors-solarized/colors/solarized.vim ~/.vim/colors/ 
    mkdir -p ~/.vim/ftplugin/
    # Pathogen
    mkdir -p ~/.vim/autoload ~/.vim/bundle
    curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    # Vim Notes
    git clone git@github.com:xolox/vim-notes.git ~/.vim/bundle/vim-notes
    # Vim Misc
    git clone git@github.com:xolox/vim-misc.git ~/.vim/bundle/vim-misc
    # Vim Sensible
    git clone git://github.com/tpope/vim-sensible.git ~/.vim/bundle/vim-sensible
    # Custom vim file
    cat > ~/.vim_runtime/my_configs.vim << EOL
        execute pathogen#infect()
        set number
       	syntax on
        indent on
        filetype plugin indent on 
EOL
fi

export PS1="\n\[$(tput bold)\]\u:\W\\$ \[$(tput sgr0)\]"

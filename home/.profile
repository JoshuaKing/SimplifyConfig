
# MacPorts Installer addition on 2014-04-13_at_19:12:00: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.


var1=$1
var2=$2
var3=$3


# Stream Twitch to VLC
alias stream="livestreamer $var1 source --hls-segment-threads 5 --player-passthrough hls"

# Use SSH with the work-from-home key
alias sshwork="ssh -i ~/.ssh/work_from_home"

# With the .m2/settings.xml profile - disable many tests, checks, and only run the bare minimum to compile and then execute
alias mvnq="mvn package -Pquick && ./start.sh"

# list-long and list-long-alphabetic - Display only useful ls data, in a presentable format (human-readable sizing, correct width columns)
listlong() {
	ls -lhPpA $1 | tr -s ' ' | cut -d' ' -f1,3,5,9 | column -t
}
alias ll=listlong

# l - last file to be used
#alias l="history | egrep -o \"(\\s|^)~?[a-zA-Z0-9_-]*[./][./a-zA-Z0-9_-]*[^.](\\s|$)\" | tr -d ' ' | tail -1"

# source profile quickly
alias profile="source ~/.profile"

if [ ! -d ~/.vim_runtime ]; then 
	git clone git://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_basic_vimrc.sh
fi

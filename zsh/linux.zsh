# Old linux commands I may never actually use
#
if [ "$TERM" = "xterm" ]
then
    export TERM="xterm-256color"
fi

# linux term things
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

bindkey    "^[[3~"          delete-char
bindkey    "^[3;5~"         delete-char

# Old, replace with pyenv or uv when needed
if [ -f /usr/bin/virtualenvwrapper.sh ]
then
    source /usr/bin/virtualenvwrapper.sh
fi

export WORKON_HOME=$HOME/pyenvs
export PROJECT_HOME=$HOME/work/code
if [ -f /usr/bin/virtualenvwrapper.sh ]
then
    source /usr/bin/virtualenvwrapper.sh
fi

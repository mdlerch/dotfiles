#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

export PATH=$PATH:~/bin/:~/work/bin/

if [ -f ~/.bash_alias ]; then
  . ~/.bash_alias
fi

# My bash prompt
if [ -f ~/.bash_prompt ]; then
  . ~/.bash_prompt
fi

# Add Sweave to texpath
TEXINPUTS=${TEXINPUTS}:/usr/share/R/texmf//
export TEXINPUTS

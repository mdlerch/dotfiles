# vim: ft=zsh

# --- Editor ---
# ovim: opens a file in a running vim server instance (vim client-server mode)
alias ovim='/usr/bin/vim --servername VIM'
alias vi='nvim'
alias vim='nvim'
alias vir='nvim -R'   # open read-only

# --- File listing ---
# Requires GNU coreutils: brew install coreutils
alias ls='gls --color=auto --group-directories-first'
alias lt='gls --color=auto --group-directories-first -t'   # sort by modified time

# --- Safety / defaults ---
alias mv='mv -i'          # prompt before overwrite
alias grep='grep --color'

# --- Applications ---
alias R='R --no-save --no-restore-data'
alias cmus="player"   # wrapper script that launches cmus with custom settings
alias darktable='darktable --noiseprofiles ~/dotfiles/noiseprofiles.json'

# --- Utilities ---
alias unix2dos='dos2unix -D'

# --- Pi storage ---
alias reconnectpi='diskutil unmount force ~/pi 2>/dev/null; sshfs miggy@192.168.1.100:/home/pi ~/pi -o reconnect,volname=PiStorage,ConnectTimeout=5,ServerAliveInterval=15'

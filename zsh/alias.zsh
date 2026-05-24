alias ovim='/usr/bin/vim --servername VIM'
alias vi='nvim'
alias vim='nvim'
alias vir='nvim -R'
alias ls='gls --color=auto --group-directories-first'
alias lt='gls --color=auto --group-directories-first -t'
alias mv='mv -i'
alias grep='grep --color'
alias R='R --no-save --no-restore-data'
alias unix2dos='dos2unix -D'
alias cmus="player"
alias darktable='darktable --noiseprofiles ~/dotfiles/noiseprofiles.json'
#
#
alias sshfs='/opt/homebrew/Cellar/sshfs-fuse-t/2026.05.12-cebbdd3/bin/sshfs'

alias reconnectpi='diskutil unmount force ~/pi 2>/dev/null; sshfs miggy@192.168.1.100:/home/pi ~/pi -o reconnect,volname=PiStorage,ConnectTimeout=5,ServerAliveInterval=15'

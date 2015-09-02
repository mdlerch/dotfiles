alias ovim='/usr/bin/vim --servername VIM'
alias vi='nvim'
alias vim='nvim'
alias vir='nvim -R'
# if [ "$HOST" == "WF12611" ];
# then
    # alias ls='ls -G'
# else
    alias ls='ls --color=auto --group-directories-first'
    alias lt='ls --color=auto --group-directories-first -t'
# fi
alias mv='mv -i'
alias grep='grep --color'
alias n='urxvtc &'
alias rsyncwork='rsync -av --size-only /data/work /media/storage/rsync.d'
alias rsyncwallpapers='rsync -av --size-only /data/wallpapers /media/storage/rsync.d'
alias rsyncpictures='rsync -av --size-only /data/pictures /media/storage/rsync.d'
alias rsyncpodcasts='rsync -av --size-only /data/podcasts /media/storage/rsync.d'
alias rsyncmusic='rsync -av --size-only /data/music /media/storage/rsync.d'
alias rsyncdotfiles='rsync -av --size-only /home/mike/dotfiles /media/storage/rsync.d'
alias R='R --no-save --no-restore-data'
alias newton='ssh 153.90.244.122 -p 22122 -l lerch'
alias newtonx='ssh -X 153.90.244.122 -p 22122 -l lerch'
alias gauss='ssh gauss.math.montana.edu -l lerch'
alias gaussx='ssh -X gauss.math.montana.edu -l lerch'
alias mgaussfs='sshfs lerch@gauss.math.montana.edu:/mnt/grad/lerch ~/work/storage/gauss/'
alias ugaussfs='fusermount -u ~/work/storage/gauss/'
alias euclid='ssh -X euclid.math.montana.edu -l q63v216'
alias meuclidfs='sshfs q63v216@euclid.math.montana.edu:/mnt/home/q63v216 ~/work/storage/euclid/'
alias ueuclidfs='fusermount -u ~/work/storage/euclid/'
alias knox='cadaver https://knox.montana.edu/retention'
alias knoxcareer='cadaver https://knox.montana.edu/CareerServices'
alias combinepdf='gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combinedpdf.pdf -dBATCH '
alias unix2dos='dos2unix -D'
alias skype='xhost +local: && sudo -u skype /usr/bin/skype'
alias mutt="if [ "$TMUX" ]; then tmux move-window -t 8; tmux rename-window 'mutt'; fi; mutt"
alias cmus="player"
alias pynchclock="if [ "$TMUX" ]; then tmux setw monitor-activity off; tmux move-window -t 9; tmux rename-window 'time'; fi; cd ~/work/time/; pynchclock"
#alias ipython="python /usr/bin/ipython"

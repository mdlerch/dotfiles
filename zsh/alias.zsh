alias vi='vim --servername VIM'
alias vim='vim --servername VIM'
alias ls='ls --color=auto --group-directories-first'
alias vir='vim -R'
alias grep='grep --color'
alias n='urxvtc &'
alias rsyncwork='rsync -av --size-only /data/work /var/run/media/mike/storage/rsync.d'
alias rsyncwallpapers='rsync -av --size-only /data/wallpapers /var/run/media/mike/storage/rsync.d'
alias rsyncpictures='rsync -av --size-only /data/pictures /var/run/media/mike/storage/rsync.d'
alias rsyncpodcasts='rsync -av --size-only /data/podcasts /var/run/media/mike/storage/rsync.d'
alias rsyncmusic='rsync -av --size-only /data/music /var/run/media/mike/storage/rsync.d'
alias rsyncdotfiles='rsync -av --size-only /home/mike/dotfiles /var/run/media/mike/storage/rsync.d'
alias R='R --no-save --no-restore-data'
alias gauss='ssh gauss.math.montana.edu -l lerch'
alias gaussx='ssh -X gauss.math.montana.edu -l lerch'
alias newton='ssh 153.90.244.122 -p 22122 -l lerch'
alias newtonx='ssh -X 153.90.244.122 -p 22122 -l lerch'
alias gaussfs='sshfs lerch@gauss.math.montana.edu:/mnt/grad/lerch ~/work/storage/gauss/'
alias ugaussfs='fusermount -u ~/work/storage/gauss/'
alias euclidfs='sshfs q63v216@euclid.math.montana.edu:/mnt/home/q63v216 ~/work/storage/euclid/'
alias euclid='ssh euclid.math.montana.edu -l q63v216'
alias ueuclidfs='fusermount -u ~/work/storage/euclid/'
alias knox='cadaver https://knox.montana.edu/retention'
alias knoxcareer='cadaver https://knox.montana.edu/CareerServices'
alias combinepdf='gs -dNOPAUSE -sDEVICE=pdfwrite -sOUTPUTFILE=combinedpdf.pdf -dBATCH '
alias unix2dos='dos2unix -D'
alias skype='xhost +local: && sudo -u skype /usr/bin/skype'
alias mocp="if [ "$TMUX" ]; then tmux setw monitor-activity off; tmux move-window -t 9; tmux rename-window 'mocp'; fi; mocp -A"
alias mutt="if [ "$TMUX" ]; then tmux move-window -t 8; tmux rename-window 'mutt'; fi; mutt"
alias cmus="player"
#alias ipython="python /usr/bin/ipython"

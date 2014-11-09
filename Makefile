DOTDIR = ~/dotfiles
LINK = ln -f -s

linux: bash_ ctags_ git_ gnuplot_ inputrc_ R_ screen_it_ tmux_ zsh_

arch: linux awesome_ cmus_ fonts_ mutt_ offlineimap_ user_dirs_ xdefaults_ xmodmap_ 

awesome_: awesome/rc.lua awesome/theme.lua
	${LINK} ${DOTDIR}/awesome/ ~/.config/awesome

bash_: bash/ bashrc
	${LINK} ${DOTDIR}/bash ~/.bash
	${LINK} ${DOTDIR}/bash/bashrc ~/.bashrc

cmus_: cmus/autosave
	${LINK} ${DOTDIR}/cmus/ ~/.config/cmus/

ctags_: ctags
	${LINK} ${DOTDIR}/ctags ~/.ctags

fonts_: fonts.conf
	${LINK} ${DOTDIR}/fonts.conf ~/.fonts.conf

git_: git/gitconfig git/gitignore_global
	${LINK} ${DOTDIR}/git/gitconfig ~/.gitconfig
	${LINK} ${DOTDIR}/git/gitignore_global ~/.gitignore_global

gnuplot_: gnuplot
	${LINK} ${DOTDIR}/gnuplot ~/.gnuplot

inputrc_: inputrc
	${LINK} ${DOTDIR}/inputrc ~/.inputrc

moc_: moc/
	${LINK} ${DOTDIR}/moc/ ~/.moc

mutt_: mutt/
	${LINK} ${DOTDIR}/mutt/ ~/.mutt

offlineimap_: offlineimaprc
	${LINK} ${DOTDIR}/offlineimaprc/ ~/.offlineimaprc

R_: Renviron Rprofile
	${LINK} ${DOTDIR}/Rprofile ~/.Rprofile
	${LINK} ${DOTDIR}/Renviron ~/.Renviron

screen_it_: screen-it.txt
	tic screen-it.txt

tmux_: tmux.conf
	${LINK} ${DOTDIR}/tmux.conf ~/.tmux.conf

user_dirs_: user-dirs.dirs
	${LINK} ${DOTDIR}/user-dirs.dirs ~/.config/user-dirs.dirs

xdefaults_: Xdefaults
	${LINK} ${DOTDIR}/Xdefaults ~/.Xdefaults

xmodmap_: Xmodmap
	${LINK} ${DOTDIR}/xmodmap/Xmodmap ~/.Xmodmap
	${LINK} ${DOTDIR}/xmodmap/Xmodmap2 ~/.Xmodmap2
	${LINK} ${DOTDIR}/xmodmap/Xmodmap3 ~/.Xmodmap3

zsh_: zshrc zsh
	${LINK} ${DOTDIR}/zsh/zshrc ~/.zshrc
	${LINK} ${DOTDIR}/zsh/zprofile ~/.zprofile
	${LINK} ${DOTDIR}/zsh/ ~/.zsh


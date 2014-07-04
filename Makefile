DOTDIR = ~/dotfiles
LINK = ln -f -s

essentials: git_ zsh_ gnuplot_ R_ inputrc_ tmux_

all: essentials awesome_ moc_ mutt_ bash_ inputrc_

reallyall: all user_dirs_ mutt_ awesome_ xdefaults_ xmodmap_ screen_it_

git_: git/gitconfig git/gitignore_global
	${LINK} ${DOTDIR}/git/gitconfig ~/.gitconfig
	${LINK} ${DOTDIR}/git/gitignore_global ~/.gitignore_global

zsh_: zshrc zsh
	${LINK} ${DOTDIR}/zshrc ~/.zshrc
	${LINK} ${DOTDIR}/zprofile ~/.zprofile
	${LINK} ${DOTDIR}/zsh/ ~/.zsh

awesome_: awesome/rc.lua awesome/theme.lua
	${LINK} ${DOTDIR}/awesome/ ~/.config/awesome

moc_: moc/
	${LINK} ${DOTDIR}/moc/ ~/.moc

mutt_: mutt/
	${LINK} ${DOTDIR}/mutt/ ~/.mutt

bash_: bash/ bashrc
	${LINK} ${DOTDIR}/bash ~/.bash
	${LINK} ${DOTDIR}/bashrc ~/.bashrc

gnuplot_: gnuplot
	${LINK} ${DOTDIR}/gnuplot ~/.gnuplot

inputrc_: inputrc
	${LINK} ${DOTDIR}/inputrc ~/.inputrc

R_: Renviron Rprofile
	${LINK} ${DOTDIR}/Rprofile ~/.Rprofile
	${LINK} ${DOTDIR}/Renviron ~/.Renviron

tmux_: tmux.conf
	${LINK} ${DOTDIR}/tmux.conf ~/.tmux.conf

user_dirs_: user-dirs.dirs
	${LINK} ${DOTDIR}/user-dirs.dirs ~/.config/user-dirs.dirs

xdefaults_: Xdefaults
	${LINK} ${DOTDIR}/Xdefaults ~/.Xdefaults

xmodmap_: Xmodmap
	${LINK} ${DOTDIR}/Xmodmap ~/.Xmodmap

screen_it_: screen-it.txt
	tic screen-it.txt

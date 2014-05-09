DOTDIR = ~/dotfiles

essentials: git_ zsh_ gnuplot_ R_ inputrc_ tmux_

all: essentials awesome_ moc_ mutt_ bash_ inputrc_

reallyall: all user_dirs_ mutt_ awesome_ xdefaults_ xmodmap_

git_: git/gitconfig git/gitignore_global
	ln -s ${DOTDIR}/git/gitconfig ~/.gitconfig
	ln -s ${DOTDIR}/git/gitignore_global ~/.gitignore_global

zsh_: zshrc zsh
	ln -s ${DOTDIR}/zshrc ~/.zshrc
	ln -s ${DOTDIR}/zsh/ ~/.zsh

awesome_: awesome/rc.lua awesome/theme.lua
	ln -s ${DOTDIR}/awesome/ ~/.config/awesome

moc_: moc/
	ln -s ${DOTDIR}/moc/ ~/.moc

mutt_: mutt/
	ln -s ${DOTDIR}/mutt/ ~/.mutt

bash_: bash/ bashrc
	ln -s ${DOTDIR}/bash ~/.bash
	ln -s ${DOTDIR}/bashrc ~/.bashrc

gnuplot_: gnuplot
	ln -s ${DOTDIR}/gnuplot ~/.gnuplot

inputrc_: inputrc
	ln -s ${DOTDIR}/inputrc ~/.inputrc

R_: Renviron Rprofile
	ln -s ${DOTDIR}/Rprofile ~/.Rprofile
	ln -s ${DOTDIR}/Renviron ~/.Renviron

tmux_: tmux.conf
	ln -s ${DOTDIR}/tmux.conf ~/.tmux.conf

user_dirs_: user-dirs.dirs
	ln -s ${DOTDIR}/user-dirs.dirs ~/.config/user-dirs.dirs

xdefaults_: Xdefaults
	ln -s ${DOTDIR}/Xdefaults ~/.Xdefaults

xmodmap_: Xmodmap
	ln -s ${DOTDIR}/Xmodmap ~/.Xmodmap

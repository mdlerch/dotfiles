DOTDIR = $(CURDIR)
LINK = ln -s

define INFECT
if [ -L $(2) ] && [ "$$(readlink $(2))" = "$(DOTDIR)/$(1)" ]; then \
    echo "  ok: $(2)"; \
elif [ -L $(2) ]; then \
    echo "  WARNING: $(2) is a symlink pointing elsewhere: $$(readlink $(2))"; \
elif [ -e $(2) ]; then \
    echo "  WARNING: $(2) is a real file — skipping. Remove manually to link."; \
else \
    $(LINK) $(DOTDIR)/$(1) $(2) && echo "  linked: $(2)"; \
fi
endef

all: macos

macos: git_ zsh_ tmux_ R_ ctags_ inputrc_
linux: macos bash_ gnuplot_ zathura_
arch: linux awesome_ cmus_ fonts_ mutt_ offlineimap_ user_dirs_ xdefaults_ xmodmap_ xprofile_

.PHONY: status
status:
	@echo "=== Dotfile symlink status ==="
	@ls -la ~ | grep "$(CURDIR)" || true
	@ls -la ~/.config 2>/dev/null | grep "$(CURDIR)" || true

.PHONY: awesome_
awesome_: awesome
	@$(call INFECT,awesome,~/.config/awesome)

.PHONY: bash_
bash_: bash/bashrc
	@$(call INFECT,bash,~/.bash)
	@$(call INFECT,bash/bashrc,~/.bashrc)

.PHONY: cmus_
cmus_: cmus
	@$(call INFECT,cmus,~/.config/cmus)

.PHONY: ctags_
ctags_: ctags
	@$(call INFECT,ctags,~/.ctags)

.PHONY: fonts_
fonts_: fonts.conf
	@$(call INFECT,fonts.conf,~/.fonts.conf)

.PHONY: git_
git_: git/gitconfig git/gitignore_global
	@$(call INFECT,git/gitconfig,~/.gitconfig)
	@$(call INFECT,git/gitignore_global,~/.gitignore_global)

.PHONY: gnuplot_
gnuplot_: gnuplot
	@$(call INFECT,gnuplot,~/.gnuplot)

.PHONY: inputrc_
inputrc_: inputrc
	@$(call INFECT,inputrc,~/.inputrc)

.PHONY: moc_
moc_: moc/
	@$(call INFECT,moc,~/.moc)

.PHONY: mutt_
mutt_: mutt/
	@$(call INFECT,mutt,~/.mutt)

.PHONY: offlineimap_
offlineimap_: offlineimaprc
	@$(call INFECT,offlineimaprc,~/.offlineimaprc)

.PHONY: R_
R_: Renviron Rprofile
	@$(call INFECT,Rprofile,~/.Rprofile)
	@$(call INFECT,Renviron,~/.Renviron)

.PHONY: roxterm_
roxterm_: roxterm
	@$(call INFECT,roxterm,~/.config/roxterm.sourceforge.net)

.PHONY: screen_it_
screen_it_: screen-it.txt
	tic screen-it.txt

.PHONY: tmux_
tmux_: tmux.conf
	@$(call INFECT,tmux.conf,~/.tmux.conf)

.PHONY: user_dirs_
user_dirs_: user-dirs.dirs
	@$(call INFECT,user-dirs.dirs,~/.config/user-dirs.dirs)

.PHONY: xdefaults_
xdefaults_: Xdefaults
	@$(call INFECT,Xdefaults,~/.Xdefaults)

.PHONY: xmodmap_
xmodmap_: xmodmap
	@$(call INFECT,xmodmap/Xmodmap,~/.Xmodmap)
	@$(call INFECT,xmodmap/Xmodmap2,~/.Xmodmap2)
	@$(call INFECT,xmodmap/Xmodmap3,~/.Xmodmap3)

.PHONY: xprofile_
xprofile_: zsh/zprofile
	@$(call INFECT,zsh/zprofile,~/.xprofile)

.PHONY: zathura_
zathura_: zathura
	@$(call INFECT,zathura,~/.config/zathura)

.PHONY: zsh_
zsh_: zsh/zshrc zsh/zprofile
	@$(call INFECT,zsh,~/.zsh)
	@$(call INFECT,zsh/zshrc,~/.zshrc)
	@$(call INFECT,zsh/zprofile,~/.zprofile)

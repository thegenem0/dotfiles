MKDIR=mkdir -p
LN=ln -vsf
LNDIR=ln -vs
PKGINSTALL=sudo pacman --noconfirm -S
YAYINSTALL=yay --noconfirm -S
XDGBASE=$(PWD)/xdg_config

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

install:
	$(PKGINSTALL) --needed - < $(XDGBASE)/arch/pacmanlist
	$(YAYINSTALL) --needed - < $(XDGBASE)/arch/aurlist

pkgbackup:
	pacman -Qnq > $(PWD)/arch/pacmanlist
	pacman -Qqem > $(PWD)/arch/aurlist

configbackup:
	$(MKDIR) $(HOME)/.config/backup/
	@test -L $(HOME)/.config/nvim/ || (test ! -d $(HOME)/.config/nvim/ || (echo "Backing up existing nvim config..." && mv $(HOME)/.config/nvim/ $(HOME)/.config/backup/nvim.backup/))
	@test -L $(HOME)/.zshrc || (test ! -f $(HOME)/.zshrc || (echo "Backing up existing zshrc..." && mv $(HOME)/.zshrc $(HOME)/.config/backup/.zshrc.backup))
	@test -L $(HOME)/.p10k.zsh || (test ! -f $(HOME)/.p10k.zsh || (echo "Backing up existing p10k.zsh..." && mv $(HOME)/.p10k.zsh $(HOME)/.config/backup/.p10k.zsh.backup))
	@test -L $(HOME)/.i3/ || (test ! -d $(HOME)/.i3/ || (echo "Backing up existing i3 config..." && mv $(HOME)/.i3/ $(HOME)/.config/backup/i3.backup/))
	@test -L $(HOME)/.i3status/ || (test ! -d $(HOME)/.i3status/ || (echo "Backing up existing i3status config..." && mv $(HOME)/.i3status/ $(HOME)/.config/backup/i3status.backup/))
	@test -L $(HOME)/.config/kitty/ || (test ! -d $(HOME)/.config/kitty/ || (echo "Backing up existing kitty config..." && mv $(HOME)/.config/kitty/ $(HOME)/.config/backup/kitty.backup/))
	@test -L $(HOME)/.config/fastfetch/ || (test ! -d $(HOME)/.config/fastfetch/ || (echo "Backing up existing fastfetch config..." && mv $(HOME)/.config/fastfetch/ $(HOME)/.config/backup/fastfetch.backup/))
	@test -L $(HOME)/.config/picom.conf || (test ! -f $(HOME)/.config/picom.conf || (echo "Backing up existing picom config..." && mv $(HOME)/.config/picom.conf $(HOME)/.config/backup/picom.conf.backup))
	@test -L $(HOME)/.ssh/ || (test ! -d $(HOME)/.ssh/ || (echo "Backing up existing ssh config..." && mv $(HOME)/.ssh/ $(HOME)/.config/backup/ssh.backup/))

nvim:
	$(PKGINSTALL) $@
	@echo "Symlinking neovim config..."
	$(MKDIR) ~/.config/nvim/
	$LNDIR $(XDGBASE)/nvim/* ~/.config/nvim/

zsh:
	$(PKGINSTALL) $@
	@echo "Symlinking zsh config..."
	$(LN) $(XDGBASE)/.zshrc ~/.zshrc
	$(LN) $(XDGBASE)/.p10k.zsh ~/.p10k.zsh

i3:
	$(PKGINSTALL) $@
	@echo "Symlinking i3 config..."
	$(MKDIR) ~/.i3/
	$(LNDIR) $(XDGBASE)/i3/* ~/.i3/

i3status:
	$(PKGINSTALL) $@
	@echo "Symlinking i3status config..."
	$(MKDIR) ~/.i3status/
	$(LNDIR) $(XDGBASE)/i3status/* ~/.config/i3status/

kitty:
	$(PKGINSTALL) $@
	@echo "Symlinking kitty config..."
	$(MKDIR) ~/.config/kitty/
	$(LNDIR) $(XDGBASE)/kitty/* ~/.config/kitty/

fastfetch:
	$(PKGINSTALL) $@
	@echo "Symlinking fastfetch config..."
	$(MKDIR) ~/.config/fastfetch/
	$(LNDIR) $(XDGBASE)/fastfetch/* ~/.config/fastfetch/

picom:
	$(PKGINSTALL) $@
	@echo "Symlinking picom config..."
	$(LN) $(XDGBASE)/picom.conf ~/.config/picom.conf

ssh:
	$(PKGINSTALL) $@
	@echo "Symlinking ssh config..."
	$(MKDIR) ~/.ssh/
	$(LNDIR) $(PWD)/.ssh/* ~/.ssh/

MKDIR=mkdir -p
RMDIR=rm -rf
LN=ln -vsf
LNDIR=ln -vs
CP=cp -r
PKGINSTALL=sudo pacman --noconfirm -S
AURINSTALL=yay --noconfirm -S
XDGBASE=$(PWD)/xdg_config

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

config: install i3-wm i3status zsh ssh ssh-set-perms kitty picom rofi fastfetch neovim 

hypr: install-base settings dunst fastfetch hypr login neovim picom rofi scripts sddm wal waybar wlogout

install-base:
	@./install.sh

settings:
	@echo "Setting up settings..."
	$(RMDIR) ~/.config/.settings
	$(LN) $(XDGBASE)/.settings ~/.config/.settings

dunst:
	$(PKGINSTALL) $@
	@echo "Symlinking dunst config..."
	$(RMDIR) ~/.config/dunst
	$(LN) $(XDGBASE)/dunst ~/.config/dunst

fastfetch:
	$(AURINSTALL) $@
	@echo "Symlinking fastfetch config..."
	$(RMDIR) ~/.config/fastfetch
	$(LN) $(XDGBASE)/fastfetch ~/.config/fastfetch

hypr:
	@echo "Symlinking hypr config..."
	$(RMDIR) ~/.config/hypr
	$(LN) $(XDGBASE)/hypr ~/.config/hypr

login:
	@echo "Symlinking login config..."
	$(RMDIR) ~/.config/login
	$(LN) $(XDGBASE)/login ~/.config/login

neovim:
	$(PKGINSTALL) $@
	@echo "Symlinking neovim config..."
	$(RMDIR) ~/.config/nvim
	$(LN) $(XDGBASE)/nvim ~/.config/nvim

picom:
	$(PKGINSTALL) $@
	@echo "Symlinking picom config..."
	$(LN) $(XDGBASE)/picom.conf ~/.config/picom.conf

rofi:
	$(AURINSTALL) rofi-lbonn-wayland
	@echo "Symlinking rofi config..."
	$(RMDIR) ~/.config/rofi
	$(LN) $(XDGBASE)/rofi ~/.config/rofi

scripts:
	@echo "Symlinking scripts..."
	$(RMDIR) ~/.config/scripts
	$(LN) $(XDGBASE)/scripts ~/.config/scripts

sddm:
	@echo "Symlinking sddm config..."
	$(RMDIR) ~/.config/sddm
	$(LN) $(XDGBASE)/sddm ~/.config/sddm
	
wal:
	@echo "Symlinking wal config..."
	$(RMDIR) ~/.config/wal
	$(LN) $(XDGBASE)/wal ~/.config/wal

waybar:
	$(AURINSTALL) $@
	@echo "Symlinking waybar config..."
	$(RMDIR) ~/.config/waybar
	$(LN) $(XDGBASE)/waybar ~/.config/waybar

wlogout:
	@echo "Symlinking wlogout config..."
	$(RMDIR) ~/.config/wlogout
	$(LN) $(XDGBASE)/wlogout ~/.config/wlogout

ssh-set-perms: ## Sets rw perms for ssh files
	@chmod 700 ~/.ssh
		@for file in ~/.ssh/*; do \
			if [ -f "$$file" ]; then \
				case "$$file" in \
					~/.ssh/known_hosts|~/.ssh/config) chmod 644 $$file ;; \
					*) chmod 600 $$file ;; \
				esac \
			fi \
		done



# install: ## Installs Pacman and AUR packages
# 	@./source_install.sh
# 	# $(PKGINSTALL) --needed - < $(XDGBASE)/arch/pacmanlist
# 	# $(YAYINSTALL) --needed - < $(XDGBASE)/arch/aurlist
#
# pkgbackup: ## Backs up Pacman and AUR packages
# 	@pacman -Qne | grep -v "$(pacman -Qmq)" > $(PWD)/arch/pacmanlist
# 	@pacman -Qqem > $(PWD)/arch/aurlist
#
# configbackup: ## Backs up config files
# 	$(MKDIR) $(HOME)/.config/backup/
# 	@test -L $(HOME)/.config/nvim/ || (test ! -d $(HOME)/.config/nvim/ || (echo "Backing up existing nvim config..." && mv $(HOME)/.config/nvim/ $(HOME)/.config/backup/nvim.backup/))
# 	@test -L $(HOME)/.zshrc || (test ! -f $(HOME)/.zshrc || (echo "Backing up existing zshrc..." && mv $(HOME)/.zshrc $(HOME)/.config/backup/.zshrc.backup))
# 	@test -L $(HOME)/.p10k.zsh || (test ! -f $(HOME)/.p10k.zsh || (echo "Backing up existing p10k.zsh..." && mv $(HOME)/.p10k.zsh $(HOME)/.config/backup/.p10k.zsh.backup))
# 	@test -L $(HOME)/.i3/ || (test ! -d $(HOME)/.i3/ || (echo "Backing up existing i3 config..." && mv $(HOME)/.i3/ $(HOME)/.config/backup/i3.backup/))
# 	@test -L $(HOME)/.i3status/ || (test ! -d $(HOME)/.i3status/ || (echo "Backing up existing i3status config..." && mv $(HOME)/.i3status/ $(HOME)/.config/backup/i3status.backup/))
# 	@test -L $(HOME)/.config/kitty/ || (test ! -d $(HOME)/.config/kitty/ || (echo "Backing up existing kitty config..." && mv $(HOME)/.config/kitty/ $(HOME)/.config/backup/kitty.backup/))
# 	@test -L $(HOME)/.config/fastfetch/ || (test ! -d $(HOME)/.config/fastfetch/ || (echo "Backing up existing fastfetch config..." && mv $(HOME)/.config/fastfetch/ $(HOME)/.config/backup/fastfetch.backup/))
# 	@test -L $(HOME)/.config/picom.conf || (test ! -f $(HOME)/.config/picom.conf || (echo "Backing up existing picom config..." && mv $(HOME)/.config/picom.conf $(HOME)/.config/backup/picom.conf.backup))
# 	@test -L $(HOME)/.ssh/ || (test ! -d $(HOME)/.ssh/ || (echo "Backing up existing ssh config..." && mv $(HOME)/.ssh/ $(HOME)/.config/backup/ssh.backup/))
#
# neovim: ## Installs neovim and symlinks config
# 	#$(PKGINSTALL) $@
# 	@echo "Symlinking neovim config..."
# 	$(RMDIR) ~/.config/nvim
# 	$(LN) $(XDGBASE)/nvim ~/.config/nvim
#
# zsh: ## Installs zsh and symlinks config
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking zsh config..."
# 	$(LN) $(XDGBASE)/.zshrc ~/.zshrc
# 	$(LN) $(XDGBASE)/.p10k.zsh ~/.p10k.zsh
#
# i3-wm: ## Installs i3 and symlinks config
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking i3 config..."
# 	$(RMDIR) ~/.config/i3
# 	$(LN) $(XDGBASE)/i3 ~/.config/i3
# 	@chmod -R +x ~/.config/i3/scripts
#
# dunst:
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking dunst config..."
# 	$(RMDIR) ~/.config/dunst
# 	$(LN) $(XDGBASE)/dunst ~/.config/dunst
#
# i3status: ## Installs i3status and symlinks config
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking i3status config..."
# 	$(RMDIR) ~/.config/i3status
# 	$(LN) $(XDGBASE)/i3status ~/.config/i3status
#
# kitty: ## Installs kitty and symlinks config
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking kitty config..."
# 	$(RMDIR) ~/.config/kitty/
# 	$(LN) $(XDGBASE)/kitty ~/.config/kitty
#
# fastfetch: ## Symlinks fastfetch config
# 	@echo "Symlinking fastfetch config..."
# 	$(RMDIR) ~/.config/fastfetch
# 	$(LN) $(XDGBASE)/fastfetch ~/.config/fastfetch
#
# picom: ## Installs picom and symlinks config
# 	$(PKGINSTALL) $@
# 	@echo "Symlinking picom config..."
# 	$(LN) $(XDGBASE)/picom.conf ~/.config/picom.conf
#
# rofi: ## Installs rofi and symlinks config
# 	$(AURINSTALL) $@
# 	@echo "Symlinking rofi config..."
# 	$(RMDIR) ~/.config/rofi
# 	$(LN) $(XDGBASE)/rofi ~/.config/rofi
#
# ssh: ## Installs ssh and symlinks config
# 	@echo "Symlinking ssh config..."
# 	$(RMDIR) ~/.ssh
# 	$(LN) $(PWD)/.ssh ~/.ssh
#



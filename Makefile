MKDIR=mkdir -p
RMDIR=rm -rf
LN=ln -vsf
LNDIR=ln -vs
CP=cp -r
PKGINSTALL=sudo pacman --noconfirm -S
AURINSTALL=paru --noconfirm -S
XDGBASE=$(PWD)/xdg_config

.DEFAULT_GOAL := help

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
	| sort \
	| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

config: install i3-wm i3status zsh ssh ssh-set-perms kitty picom rofi fastfetch neovim 


install: ## Installs Pacman and AUR packages
	@./source_install.sh
	# $(PKGINSTALL) --needed - < $(XDGBASE)/arch/pacmanlist
	# $(YAYINSTALL) --needed - < $(XDGBASE)/arch/aurlist

pkgbackup: ## Backs up Pacman and AUR packages
	@pacman -Qnq > $(PWD)/arch/pacmanlist
	@pacman -Qqem > $(PWD)/arch/aurlist

configbackup: ## Backs up config files
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

neovim: ## Installs neovim and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking neovim config..."
	$(RMDIR) ~/.config/nvim
	$(LN) $(XDGBASE)/nvim ~/.config/nvim

zsh: ## Installs zsh and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking zsh config..."
	$(LN) $(XDGBASE)/.zshrc ~/.zshrc
	$(LN) $(XDGBASE)/.p10k.zsh ~/.p10k.zsh

i3-wm: ## Installs i3 and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking i3 config..."
	$(RMDIR) ~/.config/i3
	$(LN) $(XDGBASE)/i3 ~/.config/i3
	@chmod -R +x ~/.config/i3/scripts

dunst:
	$(PKGINSTALL) $@
	@echo "Symlinking dunst config..."
	$(RMDIR) ~/.config/dunst
	$(LN) $(XDGBASE)/dunst ~/.config/dunst

i3status: ## Installs i3status and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking i3status config..."
	$(RMDIR) ~/.config/i3status
	$(LN) $(XDGBASE)/i3status ~/.config/i3status

kitty: ## Installs kitty and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking kitty config..."
	$(RMDIR) ~/.config/kitty/
	$(LN) $(XDGBASE)/kitty ~/.config/kitty

fastfetch: ## Symlinks fastfetch config
	@echo "Symlinking fastfetch config..."
	$(RMDIR) ~/.config/fastfetch
	$(LN) $(XDGBASE)/fastfetch ~/.config/fastfetch

picom: ## Installs picom and symlinks config
	$(PKGINSTALL) $@
	@echo "Symlinking picom config..."
	$(LN) $(XDGBASE)/picom.conf ~/.config/picom.conf

rofi: ## Installs rofi and symlinks config
	$(AURINSTALL) $@
	@echo "Symlinking rofi config..."
	$(RMDIR) ~/.config/rofi
	$(LN) $(XDGBASE)/rofi ~/.config/rofi

ssh: ## Installs ssh and symlinks config
	@echo "Symlinking ssh config..."
	$(RMDIR) ~/.ssh
	$(LN) $(PWD)/.ssh ~/.ssh

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

smb: ## 
	$(RMDIR) ~/.config/smb
	$(LN) $(XDGBASE)/smb ~/.config/smb
	@chmod -R +x ~/.config/smb/mount_smb.sh


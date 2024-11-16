dotfiles = nvim wezterm zshrc lazygit


run: $(dotfiles)
	stow $(dotfiles)


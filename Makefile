dotfiles = nvim wezterm zshrc


run: $(dotfiles)
	stow $(dotfiles)


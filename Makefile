dotfiles = nvim wezterm


run: $(dotfiles)
	stow $(dotfiles)


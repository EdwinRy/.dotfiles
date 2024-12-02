dotfiles = nvim wezterm zshrc lazygit tmux


run: $(dotfiles)
	stow $(dotfiles)


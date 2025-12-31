.DEFAULT_GOAL := help

help:
	@echo ""
	@echo "Available commands:"
	@echo "  make install   Install dependencies + setup configs"
	@echo "  make deps      Install Homebrew dependencies only"
	@echo "  make link      Symlink config files only"
	@echo "  make reload    Reload zsh config"
	@echo ""

deps:
	brew bundle

link:
	mkdir -p ~/.config/zellij/layouts
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/oh-my-posh

	ln -sf $(PWD)/zellij/config.kdl ~/.config/zellij/config.kdl
	ln -sf $(PWD)/zellij/layouts/work.kdl ~/.config/zellij/layouts/work.kdl
	ln -sf $(PWD)/ghostty/config ~/.config/ghostty/config
	ln -sf $(PWD)/oh-my-posh/theme.omp.json ~/.config/oh-my-posh/theme.omp.json

install: deps
	chmod +x setup.sh
	./setup.sh

reload:
	source ~/.zshrc

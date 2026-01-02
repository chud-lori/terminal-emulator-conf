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
	mkdir -p ~/.config/zellij/plugins
	mkdir -p ~/.config/ghostty
	mkdir -p ~/.config/oh-my-posh

	@if [ ! -f ~/.config/zellij/plugins/zjstatus.wasm ]; then \
		echo "▶ Downloading zjstatus plugin..."; \
		curl -L https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm -o ~/.config/zellij/plugins/zjstatus.wasm; \
	else \
		echo "▶ zjstatus plugin already exists, skipping download"; \
	fi

	ln -sf $(PWD)/zellij/config.kdl ~/.config/zellij/config.kdl
	ln -sf $(PWD)/zellij/layouts/work.kdl ~/.config/zellij/layouts/work.kdl
	ln -sf $(PWD)/ghostty/config ~/.config/ghostty/config
	ln -sf $(PWD)/oh-my-posh/theme.omp.json ~/.config/oh-my-posh/theme.omp.json

install: deps
	chmod +x setup.sh
	./setup.sh

reload:
	source ~/.zshrc

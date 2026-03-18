#!/usr/bin/env bash
set -e

echo "▶ Starting setup..."

if ! command -v brew >/dev/null 2>&1; then
  echo "✖ Homebrew not installed"
  exit 1
fi

if [ -f Brewfile ]; then
  echo "▶ Installing dependencies via Brewfile..."
  brew bundle
else
  echo "▶ Brewfile not found, skipping dependency install"
fi

echo "▶ Creating config directories..."

mkdir -p ~/.config/zellij/layouts
mkdir -p ~/.config/zellij/plugins
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/oh-my-posh

echo "▶ Downloading Zellij plugins..."

if [ ! -f ~/.config/zellij/plugins/zjstatus.wasm ]; then
  echo "▶ Downloading zjstatus plugin..."
  curl -L https://github.com/dj95/zjstatus/releases/latest/download/zjstatus.wasm -o ~/.config/zellij/plugins/zjstatus.wasm
else
  echo "▶ zjstatus plugin already exists, skipping download"
fi

echo "▶ Linking configuration files..."

ln -sf "$(pwd)/zellij/config.kdl" ~/.config/zellij/config.kdl
ln -sf "$(pwd)/zellij/layouts/work.kdl" ~/.config/zellij/layouts/work.kdl
ln -sf "$(pwd)/ghostty/config" ~/.config/ghostty/config
ln -sf "$(pwd)/oh-my-posh/theme.omp.json" ~/.config/oh-my-posh/theme.omp.json

ZSHRC="$HOME/.zshrc"

echo "▶ Updating .zshrc safely..."

if ! grep -q "oh-my-posh init zsh" "$ZSHRC"; then
  echo "" >> "$ZSHRC"
  echo "# Oh My Posh" >> "$ZSHRC"
  echo 'eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.omp.json)"' >> "$ZSHRC"
fi

if ! grep -q "export TERM=xterm-256color" "$ZSHRC"; then
  echo 'export TERM=xterm-256color' >> "$ZSHRC"
fi

if ! grep -q 'alias work=' "$ZSHRC"; then
    # gracefull start and start from home dir
  echo 'alias work-tab="cd; zellij delete-session work 2>/dev/null; zellij --new-session-with-layout work --session work"' >> "$ZSHRC"
fi

# zsh-autosuggestions
if ! grep -q "zsh-autosuggestions" "$ZSHRC"; then
  echo 'source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> "$ZSHRC"
fi

# zsh-syntax-highlighting
if ! grep -q "zsh-syntax-highlighting" "$ZSHRC"; then
  echo 'source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> "$ZSHRC"
fi

# fzf shell integration
if ! grep -q 'eval "$(fzf --zsh)"' "$ZSHRC"; then
  echo 'eval "$(fzf --zsh)"' >> "$ZSHRC"
fi

# Useful dev aliases
if ! grep -q "# Dev aliases" "$ZSHRC"; then
  cat >> "$ZSHRC" << 'ALIASES'

# Dev aliases
alias ls="eza --icons"
alias ll="eza -la --icons --git"
alias lt="eza --tree --icons --level=2"
alias cat="bat --style=plain"
alias grep="rg"
alias find="fd"
alias lg="lazygit"
alias k="kubectl"
alias d="docker"
alias dc="docker compose"

# fzf with ripgrep
export FZF_DEFAULT_COMMAND="rg --files --hidden --follow --glob '!.git'"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --preview 'bat --style=numbers --color=always {} 2>/dev/null || echo {}'"

# bat theme
export BAT_THEME="Atom One Dark"

# Editor
export EDITOR="nvim"
export VISUAL="nvim"
ALIASES
fi

echo "✔ Setup complete"
echo "Restart terminal or run: source ~/.zshrc"

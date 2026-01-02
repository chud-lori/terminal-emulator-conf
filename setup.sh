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
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/oh-my-posh

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
    # gracefull start
  echo 'alias work-tab="zellij delete-session work 2>/dev/null; zellij --new-session-with-layout work --session work"' >> "$ZSHRC"

fi

echo "✔ Setup complete"
echo "Restart terminal or run: source ~/.zshrc"

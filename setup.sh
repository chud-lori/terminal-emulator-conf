#!/usr/bin/env bash
set -e

echo "▶ Installing dependencies..."

brew install zellij || true
brew install jandedobbeleer/oh-my-posh/oh-my-posh || true
brew install zsh-autosuggestions || true
brew install --cask ghostty || true
brew install --cask font-jetbrains-mono-nerd-font || true

echo "▶ Creating config directories..."

mkdir -p ~/.config/zellij/layouts
mkdir -p ~/.config/ghostty
mkdir -p ~/.config/oh-my-posh

echo "▶ Linking configs..."

ln -sf "$(pwd)/zellij/config.kdl" ~/.config/zellij/config.kdl
ln -sf "$(pwd)/zellij/layouts/work.kdl" ~/.config/zellij/layouts/work.kdl
ln -sf "$(pwd)/ghostty/config" ~/.config/ghostty/config
ln -sf "$(pwd)/oh-my-posh/theme.omp.json" ~/.config/oh-my-posh/theme.omp.json

ZSHRC="$HOME/.zshrc"

echo "▶ Updating .zshrc safely..."

# Oh My Posh
if ! grep -q "oh-my-posh init zsh" "$ZSHRC"; then
  echo "" >> "$ZSHRC"
  echo "# Oh My Posh" >> "$ZSHRC"
  echo 'eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/theme.omp.json)"' >> "$ZSHRC"
fi

# TERM
if ! grep -q "export TERM=xterm-256color" "$ZSHRC"; then
  echo 'export TERM=xterm-256color' >> "$ZSHRC"
fi

# work alias
if ! grep -q 'alias work=' "$ZSHRC"; then
  echo 'alias work="zellij --layout work"' >> "$ZSHRC"
fi

echo "✔ Setup complete"
echo "Restart your terminal or run: source ~/.zshrc"

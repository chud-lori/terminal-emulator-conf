# Terminal Development Environment

A reproducible macOS terminal setup built for **software development**, optimized for **speed, clarity, and context switching**.

This repository allows me to bootstrap the same environment on any new machine with a single script.

---

## Stack

- **Terminal**: Ghostty
- **Multiplexer**: Zellij
- **Shell**: zsh
- **Prompt**: Oh My Posh
- **Font**: JetBrains Mono Nerd Font

---

## Features

- Predefined Zellij workspace (`work`)
- Multiple tabs with structured pane layouts
- Fast pane navigation without mode switching
- Fullscreen toggle per pane
- Ghostty GPU-accelerated terminal with transparency and blur
- Consistent prompt across machines

---

## Installation (macOS)

### 1. Clone repository

```bash
git clone <your-repo-url>
cd <repo>
```

---

### 2. Make setup script executable

```bash
chmod +x setup.sh
```

This is required only once per machine.

---

### 3. Run setup script

```bash
./setup.sh
```

This will:

- Install dependencies via Homebrew
- Symlink all configuration files
- Safely update `.zshrc` (no overwrite, no duplication)

---

### 4. Restart terminal

```bash
source ~/.zshrc
```

---

## Usage

Start the main workspace:

```bash
work
```

---

## Zellij Keybindings

### Tab Navigation

- **Enter tab mode**: `Ctrl + t`
- **Next tab**: `j` or `l`
- **Previous tab**: `h` or `k`
- **Jump to tab**: `Ctrl + t` then `1–9`
- **Exit mode**: `Esc`

---

### Pane Navigation (Fast, No Mode)

- `Alt + h` → move left
- `Alt + j` → move down
- `Alt + k` → move up
- `Alt + l` → move right

---

### Pane Mode

- **Enter pane mode**: `Ctrl + p`
- **Move focus**: `h j k l`
- **Exit pane mode**: `Esc`

---

### Fullscreen Pane (Toggle)

- **Fullscreen focused pane**: `Ctrl + p` then `f`
- **Restore layout**: `Ctrl + p` then `f`

This is the recommended workflow instead of resizing panes.

---

### Lock / Unlock Zellij

- **Lock input**: `Ctrl + g`
- **Unlock input**: `Ctrl + g`

Useful when copy-pasting or presenting.

---

## File Structure

```text
.
├── README.md
├── setup.sh
├── ghostty/
│   └── config
├── zellij/
│   ├── config.kdl
│   └── layouts/
│       └── work.kdl
└── oh-my-posh/
    └── theme.omp.json
```

---

## Design Philosophy

- Tabs represent **context** (Code, AI, Infra, Runner)
- Panes represent **tasks**
- Prefer fullscreen toggling over resizing
- One responsibility per pane
- Keyboard-first workflow

---

## Notes

- Zellij colors follow the terminal theme (Ghostty)
- Oh My Posh controls prompt and status colors
- Nerd Font is required for icons

---

## License

Personal dotfiles.
Use, fork, or adapt freely.

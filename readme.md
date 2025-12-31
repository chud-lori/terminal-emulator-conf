# Terminal Development Environment

A reproducible macOS terminal setup built for **software development**, optimized for **speed, clarity, and context switching**.

This repository allows me to bootstrap the same environment on any new machine with **one command**.

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
- GPU-accelerated Ghostty terminal with transparency and blur
- Reproducible setup via Brewfile + Makefile

---

## Installation (macOS)

### 1. Clone repository

```bash
git clone <your-repo-url>
cd <repo>
```

---

### 2. Install everything (recommended)

```bash
make install
```

This will:

- Install dependencies using `Brewfile`
- Symlink all configuration files
- Safely update `.zshrc`
- Make `setup.sh` executable automatically

---

### Alternative (manual steps)

If you prefer step-by-step:

```bash
chmod +x setup.sh
./setup.sh
```

Then reload shell:

```bash
source ~/.zshrc
```

---

## Usage

Start the main development workspace:

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
- **Exit tab mode**: `Esc`

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

Recommended instead of resizing panes.

---

### Lock / Unlock Zellij

- **Lock input**: `Ctrl + g`
- **Unlock input**: `Ctrl + g`

Useful for copy-paste or presentations.

---

## Makefile Commands

| Command | Description |
|------|------------|
| `make install` | Full setup (deps + configs) |
| `make deps` | Install Homebrew dependencies only |
| `make link` | Re-link config files |
| `make reload` | Reload `.zshrc` |

---

## File Structure

```text
.
├── README.md
├── Makefile
├── Brewfile
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

- **Tabs = context** (Code, AI, Infra, Runner)
- **Panes = tasks**
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

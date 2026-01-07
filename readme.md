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

## Why Zellij + Ghostty (vs. iTerm2)?

**The Transition:** I previously relied on iTerm2 for its native splits and tabs. However, as my workflow grew more complex, I moved to a **Zellij + Ghostty** stack to solve specific pain points regarding persistence and performance.

This stack decouples the **renderer** (Ghostty) from the **workspace manager** (Zellij):

1.  **Persistence & Resilience**: In iTerm2, if the app crashes or you `Cmd + Q`, your tabs and running processes die. Zellij runs as a persistent server; if Ghostty closes, your session stays alive in the background. Running `work` simply re-attaches you to your active state.
2.  **Performance (GPU vs. CPU)**: Ghostty is built in Zig and is GPU-accelerated. It handles rendering much faster and with lower latency than iTerm2, especially when dealing with high-frequency terminal output or large buffers.
3.  **Declarative Environments**: Instead of manually splitting panes every time you start a project, this setup uses `.kdl` layout files. This ensures your workspace (tabs for Code, AI, Infra) is identical every time you boot up.
4.  **Remote Continuity**: This setup is terminal-agnostic. You can SSH into this machine from any device and re-attach to the exact same Zellij session, keeping your layout and context intact across different physical locations.

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

```bash
chmod +x setup.sh
./setup.sh
source ~/.zshrc
```

---

> [!IMPORTANT]
> After `zjstatus` set up, when first time open zellij, the prompt to accept permission will appear in the bottom to type `y`, you can just click in the prompt and then type `y`, because sometimes moving to locked mode not always work

## Usage

Start the main development workspace:

```bash
work-tab
```

---

## Keyboard Notes (macOS)

On **macOS**, the following keys are equivalent:

- **Alt = Option (⌥)**

Ghostty is configured with:

- `macos-option-as-alt = true`

So all bindings using **Alt** can be triggered with the **Option (⌥)** key.

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

- `Alt / Option + h` → move left
- `Alt / Option + j` → move down
- `Alt / Option + k` → move up
- `Alt / Option + l` → move right

---

---

### Pane Sync (Multi-Input)

- **Toggle Sync Mode**: `Ctrl + t` then `s`
- **Disable Sync Mode**: `Ctrl + t` then `s` (same toggle)
- **Effect**: When enabled, any text typed in the active pane is broadcasted to **all** panes within the current tab simultaneously.
- **Visual Indicators**:
    - **Enabled**: The active tab in the status bar turns **Teal** and displays `(SYNC)`.
    - **Disabled**: The tab returns to the standard **Blue** style.

---

### Pane Split

- **Enter pane mode**: `Ctrl + p`
- **Split horizontal**: `r`
- **Split vertical**: `d`

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
- Option (⌥) is used as Alt on macOS

---

## License

Personal dotfiles.
Use, fork, or adapt freely.

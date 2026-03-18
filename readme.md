# Terminal Development Environment

A reproducible macOS terminal setup built for **software development**, optimized for **speed, clarity, and context switching**.

Bootstrap the same environment on any new machine with **one command**.

---

## Stack

| Tool | Role |
|------|------|
| [Ghostty](https://ghostty.org) | Terminal emulator (GPU-accelerated) |
| [Zellij](https://zellij.dev) | Terminal multiplexer |
| [Zsh](https://zsh.sourceforge.io) | Shell |
| [Oh My Posh](https://ohmyposh.dev) | Prompt engine |
| JetBrains Mono Nerd Font | Font with icons and ligatures |

---

## Features

- **6-tab Zellij workspace**: AI, Code, Git, Run, Infra, Shell — each with purpose-built pane layouts
- **Fast pane navigation** without mode switching (`Alt+hjkl`)
- **Rich prompt** showing Git status, active language versions (Go, Rust, Node, Python venv), command duration
- **Modern CLI tools**: `rg`, `fd`, `bat`, `eza`, `fzf`, `delta`, `lazygit`
- **Ghostty**: GPU-accelerated, font ligatures, transparency/blur, keyboard shortcuts for tabs and splits
- Fully reproducible via Brewfile + Makefile symlinks

---

## Installation (macOS)

### 1. Clone and install

```bash
git clone <your-repo-url>
cd <repo>
make install
```

`make install` will:
1. Install all dependencies via `Brewfile` (Homebrew)
2. Download the `zjstatus` Zellij plugin
3. Symlink all config files to `~/.config/`
4. Patch `~/.zshrc` with shell integrations and dev aliases

### 2. Manual (alternative)

```bash
chmod +x setup.sh
./setup.sh
source ~/.zshrc
```

> [!IMPORTANT]
> On first Zellij launch, `zjstatus` will prompt for permission at the bottom of the screen. Click the prompt and type `y` to accept.

---

## Usage

Launch the full development workspace:

```bash
work-tab
```

This starts a Zellij session named `work` using the predefined layout.

---

## Zellij Workspace Tabs

| Tab | Layout | Purpose |
|-----|--------|---------|
| **AI** | Single pane | Claude Code, ChatGPT, AI tools |
| **Code** | Editor (70%) + 2 terminal splits | Main coding + running commands |
| **Git** | lazygit (70%) + log/diff splits | Git operations and history |
| **Run** | Main pane (60%) + 2 output splits | App runner, tests, build output |
| **Infra** | Wide pane + 2 stacked right | Docker, k8s, deployments |
| **Shell** | Top pane + 2 bottom splits | General shell work |

---

## Prompt (Oh My Posh)

The prompt shows context-aware information:

**Top line (left):** `[time] zsh  branch status`
**Top line (right):** `exit-code  go-ver  rust-ver  node-ver  python-venv  duration`
**Second line:** `path`
**Third line:** `❯`

Language version segments appear **only when relevant** (Go/Rust/Node detected in project, Python venv active).
Execution time is shown only for commands taking **>500ms**.

---

## Ghostty Keybindings

| Key | Action |
|-----|--------|
| `Cmd+T` | New tab |
| `Cmd+W` | Close surface |
| `Cmd+N` | New window |
| `Cmd+1–5` | Jump to tab by number |
| `Cmd+Shift+H/L` | Previous / next tab |
| `Cmd+Shift+D` | Split down |
| `Cmd+Shift+R` | Split right |
| `Cmd+Shift+Enter` | Toggle split zoom |
| `Cmd+=` / `Cmd+-` | Increase / decrease font size |
| `Cmd+0` | Reset font size |
| `Cmd+K` | Clear screen |

---

## Zellij Keybindings

### Fast Pane Navigation (no mode needed)

| Key | Action |
|-----|--------|
| `Alt+H` | Move focus left |
| `Alt+J` | Move focus down |
| `Alt+K` | Move focus up |
| `Alt+L` | Move focus right |
| `Alt+F` | Toggle floating pane |
| `Alt+[/]` | Swap layout |

> On macOS, **Alt = Option (⌥)**. Requires `macos-option-as-alt = true` in Ghostty (already set).

### Tab Mode (`Ctrl+T`)

| Key | Action |
|-----|--------|
| `H` / `K` | Previous tab |
| `L` / `J` | Next tab |
| `1–9` | Jump to tab |
| `N` | New tab |
| `X` | Close tab |
| `Esc` | Exit tab mode |

### Pane Mode (`Ctrl+P`)

| Key | Action |
|-----|--------|
| `H J K L` | Move focus |
| `D` | Split down |
| `R` | Split right |
| `F` | Toggle fullscreen |
| `C` | Rename pane |
| `Esc` | Exit pane mode |

### Other Modes

| Key | Mode |
|-----|------|
| `Ctrl+N` | Resize mode |
| `Ctrl+H` | Move mode |
| `Ctrl+S` | Scroll mode |
| `Ctrl+O` | Session mode |
| `Ctrl+G` | Lock / unlock Zellij |
| `Ctrl+Q` | Quit Zellij |

---

## Shell Aliases (added by setup.sh)

| Alias | Command | Tool |
|-------|---------|------|
| `ls` | `eza --icons` | [eza](https://github.com/eza-community/eza) |
| `ll` | `eza -la --icons --git` | eza |
| `lt` | `eza --tree --icons --level=2` | eza |
| `cat` | `bat --style=plain` | [bat](https://github.com/sharkdp/bat) |
| `grep` | `rg` | [ripgrep](https://github.com/BurntSushi/ripgrep) |
| `find` | `fd` | [fd](https://github.com/sharkdp/fd) |
| `lg` | `lazygit` | [lazygit](https://github.com/jesseduffield/lazygit) |
| `d` | `docker` | — |
| `dc` | `docker compose` | — |
| `k` | `kubectl` | — |

`fzf` is integrated into Zsh (`Ctrl+R` history, `Ctrl+T` file picker, `Alt+C` cd) with `bat` previews.

---

## CLI Tools Installed

| Tool | Replaces | Why |
|------|----------|-----|
| `ripgrep` (`rg`) | `grep` | 10x faster, respects `.gitignore` |
| `fd` | `find` | Simpler syntax, faster |
| `bat` | `cat` | Syntax highlighting, line numbers |
| `eza` | `ls` | Icons, git status, tree view |
| `fzf` | — | Fuzzy search everything |
| `delta` | `diff` | Better git diffs with syntax highlighting |
| `lazygit` | `git` (TUI) | Full git workflow in terminal |
| `jq` | — | JSON processor |
| `yq` | — | YAML processor |
| `httpie` | `curl` | Human-friendly HTTP client |
| `tokei` | — | Count lines of code by language |
| `dust` | `du` | Disk usage visualizer |
| `procs` | `ps` | Better process viewer |
| `hyperfine` | — | CLI benchmarking |

---

## Makefile Commands

| Command | Description |
|---------|-------------|
| `make install` | Full setup (deps + configs) |
| `make deps` | Install Homebrew dependencies only |
| `make link` | Re-symlink config files |
| `make reload` | Reload `.zshrc` |

---

## File Structure

```
.
├── readme.md
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

- **Tabs = context** (AI, Code, Git, Run, Infra, Shell)
- **Panes = tasks** — one responsibility per pane
- Prefer fullscreen toggle over resizing
- Keyboard-first; mouse supported but not required
- Modern tools over POSIX defaults where there is a clear performance/UX win

---

## Notes

- Zellij status bar uses the [zjstatus](https://github.com/dj95/zjstatus) plugin (auto-downloaded by `setup.sh`)
- All colors follow Catppuccin Mocha palette
- Nerd Font required for icons in prompt, eza, and status bar

---

## License

Personal dotfiles. Use, fork, or adapt freely.

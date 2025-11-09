# macOS Dotfiles — Vim, Aerospace & SketchyBar Setup

This repository contains my personal configuration files for macOS, focused on a **minimal, productive, and aesthetic development setup**.  
It includes configurations for:

- **Vim** — lightweight code editing with GitHub Copilot and syntax enhancements  
- **Aerospace** — tiling window manager for macOS  
- **SketchyBar** — customizable status bar for macOS

---

## 🧠 Overview

| File | Description |
|------|--------------|
| `.vimrc` | Vim configuration with plugin management (`vim-plug`), Copilot integration, rainbow indentation, and language-specific enhancements. |
| `.aerospace.toml` | Tiling window manager rules and shortcuts for workspace and window navigation on macOS. |
| `sketchybarrc` | Status bar customization defining modules, colors, and indicators for system info and workspace state. |

---

## ⚙️ Installation

### 1. Clone the repo
```bash
git clone https://github.com/<your-username>/<repo-name>.git ~/dotfiles
cd ~/dotfiles

2. Symlink configurations

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.aerospace.toml ~/.aerospace.toml
ln -sf ~/dotfiles/sketchybarrc ~/.config/sketchybar/sketchybarrc

3. Install dependencies

Vim
Make sure you have vim-plug￼ installed:

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
     https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

Then open Vim and run:

:PlugInstall

Aerospace
Install via Homebrew:

brew install --cask nikitabobko/aerospace/aerospace

SketchyBar
Install via Homebrew:

brew install --cask felixkratz-formulae/sketchybar


⸻

🎨 Features

Vim
	•	GitHub Copilot integration (Tab to accept, § to dismiss)
	•	Language-specific Copilot enablement (Rust, Python, JS, etc.)
	•	Rainbow indentation for clarity
	•	Markdown preview support
	•	Minimal, distraction-free setup

Aerospace
	•	Fast workspace switching
	•	Smart window tiling and focus rules
	•	Custom keybindings in TOML format
	•	Lightweight and smooth for macOS

SketchyBar
	•	System info modules (battery, network, time)
	•	Workspace indicators synced with Aerospace
	•	Clean minimalist design with color accents

⸻

🧩 Customization

You can freely adjust:
	•	Plugin sets in .vimrc
	•	Keybindings and workspace layout in .aerospace.toml
	•	Bar layout, icons, and colors in sketchybarrc

⸻

💡 Tips
	•	To reload SketchyBar after editing:

sketchybar --reload


	•	To reload Aerospace config:

aerospace reload


	•	To check your Vim plugin status:

:PlugStatus



⸻

🧰 System Setup (Optional)

Recommended utilities for full experience:
	•	Alfred￼ – app launcher
	•	Iterm2￼ – terminal emulator
	•	Fira Code￼ – programming font with ligatures

⸻

📸 Preview

(Optional: Add screenshots of your bar, Vim theme, and tiling layout here.)

⸻

🧑‍💻 Author

Lucas Winter
macOS developer & flight simulation enthusiast ✈️
GitHub￼ • Twitter￼

⸻

📜 License

MIT License — feel free to use and modify.

⸻


---

Would you like me to tailor it a bit more — for example, if your Vim setup has a specific theme (like *dark minimal* or *VS Code style*), or if your Aerospace layout uses special workspace naming or Mac keybindings? I can refine the README tone and examples accordingly.

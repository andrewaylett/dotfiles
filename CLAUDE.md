# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What This Is

A [chezmoi](https://www.chezmoi.io/) dotfiles repository, managing configuration across macOS machines. The source state lives here; chezmoi renders templates and applies files to `~`.

Note: `~/AGENTS.md` contains user-level instructions for AI assistants and is the source of truth for cross-project preferences. This CLAUDE.md is specific to working on the dotfiles repo itself.

## Key Commands

```bash
chezmoi apply          # Apply dotfiles to home directory
chezmoi diff           # Preview changes before applying
chezmoi verify         # Check if home matches source state
chezmoi add <file>     # Add a new file to chezmoi management
```

## Chezmoi Naming Conventions

- `dot_` → `.` (e.g. `dot_config/` → `~/.config/`)
- `private_` → restrictive file permissions
- `.tmpl` suffix → Go template, rendered with data from `.chezmoi.toml.tmpl`
- `run_onchange_` → script that runs when its content changes
- `executable_` → sets executable bit
- `symlink_` → symlink (file content is the target path)
- `empty_` → creates empty file; `remove_` → removes target file
- `~` suffix → chezmoi-ignored backup, not applied

## Template Data

Defined in `.chezmoi.toml.tmpl`:
- `.email`, `.secretive.gitsigningkey` — prompted on first run
- `.brew.prefix` — `/opt/homebrew` (ARM) or `/usr/local` (Intel)
- `.chezmoi.os`, `.chezmoi.arch`, `.chezmoi.osRelease.id` — platform detection
- `.packages.darwin.brews`, `.packages.darwin.casks` — Homebrew package lists (consumed by the `run_onchange_` installer script)

## Structure

- **dot_config/fish/** — Fish shell: config, prompt, completions (jj, rustup, etc.), custom functions
- **dot_config/jj/** — Jujutsu config with custom aliases (`pre-commit`, `rebase-trunk`, etc.)
- **dot_config/ghostty/** — Ghostty terminal emulator config
- **dot_gitconfig.tmpl** — Git config (SSH commit signing via Secretive)
- **dot_local/bin/** — Custom git helper scripts and `run_onchange_` Homebrew installer
- **dot_claude/, dot_codex, dot_copilot** — AI tool configs; all reference `AGENTS.md` via symlinks
- **.chezmoiexternal.toml** — Vim plugins pulled as external git repos (pathogen, rust.vim, etc.)
- **private_Library/** — macOS LaunchAgents (Secretive SSH agent)

## Important Notes

- `AGENTS.md` at the repo root is applied to `~/AGENTS.md` and is the canonical AI assistant instructions file. `dot_claude/CLAUDE.md`, `dot_codex/AGENTS.md`, and `dot_copilot/copilot-instructions.md` all symlink to it.
- `CLAUDE.md` and `README.md` are in `.chezmoiignore` — they exist in the repo but are not applied to `~`.
- Files ending with `~` are old/backup versions kept for reference, ignored by both chezmoi and git patterns.

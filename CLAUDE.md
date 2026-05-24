# Dotfiles

Personal dotfiles for Michael Lerch. Primarily macOS (Apple Silicon) with some
Linux compatibility kept for occasional use.

## Structure

Each tool has its own directory. Files are symlinked to their proper locations
via `make` — do not edit files at their symlink destinations, always edit here.

```
zsh/          zshrc, zprofile, alias.zsh, linux.zsh
git/          gitconfig, gitconfig-personal, gitconfig-local.example
tmux/         tmux.conf
```

## Deployment

```bash
make macos    # symlink all mac-relevant dotfiles (default)
make linux    # macos + linux-specific additions
make arch     # linux + Arch/X11-specific additions
make status   # show current symlink state
make git_     # symlink just git config
make zsh_     # symlink just zsh config
```

`make` uses `$(CURDIR)` so the repo can live anywhere — not hardcoded to `~/dotfiles`.

## Files intentionally NOT tracked

- `~/.ssh/config` and all SSH keys — managed per machine
- `~/.gitconfig.local` — machine-specific git identity (see `git/gitconfig-local.example`)
- `.claude/settings.local.json` — local Claude Code permissions

## Git multi-account setup

Identity is handled via `~/.gitconfig.local` (not tracked). See
`git/gitconfig-local.example` for templates for both personal and work machines.

Personal identity is in `git/gitconfig-personal` (tracked).
Work identity goes directly in `~/.gitconfig.local` (never tracked).

SSH authentication is managed per machine via `~/.ssh/config` (not tracked).
Use host aliases when cloning (`git@github.personal:...`, `git@github.work:...`).

## Key conventions

- **Editor**: nvim
- **Shell**: zsh with vi mode (`,,` to switch to normal, `^X^E` to edit in nvim)
- **Terminal**: iTerm2 + tmux
- **Indentation**: spaces (not tabs)
- **Prefix**: tmux prefix is `C-a`
- **Linux compatibility**: Linux-specific aliases and settings live in `zsh/linux.zsh`
  (sourced conditionally on Linux, kept for portability)

## Machine notes

- **Personal machine**: dotfiles at `~/dotfiles`, only personal GitHub account
- **Work machine**: dotfiles at `~/personal/dotfiles`, work identity default,
  personal identity active for any repo under `~/personal/`

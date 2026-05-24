# Dotfiles

Personal dotfiles for macOS (Apple Silicon), with some Linux compatibility kept for portability.

## Setup

```bash
make macos
```

Then create `~/.gitconfig.local` — see `git/gitconfig-local.example` for templates.

## SSH Setup (per machine)

Each machine needs its own SSH keys generated and added to the appropriate GitHub accounts.

### Personal machine

```bash
ssh-keygen -t ed25519 -C "mdlerch@gmail.com" -f ~/.ssh/id_ed25519_personal
```

Add `~/.ssh/id_ed25519_personal.pub` to your personal GitHub account under Settings → SSH keys.

Create `~/.ssh/config`:

```
Host github.personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal
```

### Work machine

```bash
ssh-keygen -t ed25519 -C "mdlerch@gmail.com" -f ~/.ssh/id_ed25519_personal
ssh-keygen -t ed25519 -C "WORK_EMAIL" -f ~/.ssh/id_ed25519_work
```

Add each public key to its respective GitHub account.

Create `~/.ssh/config`:

```
Host github.personal
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_personal

Host github.work
  HostName github.com
  User git
  IdentityFile ~/.ssh/id_ed25519_work
```

Always clone using the alias — never bare `github.com`:

```bash
git clone git@github.personal:username/repo.git
git clone git@github.work:company/repo.git
```

## Future considerations

**atuin** — SQLite-backed history replacement. Records timestamp, directory, exit code,
and session per command. Great fuzzy TUI (replaces Ctrl+R), handles multiple tmux panes
elegantly, and can sync history across machines. Pairs well with the existing fzf workflow.

```bash
brew install atuin
```

Then add the init line to `zsh/zshrc`.

# Dotfiles Modernization TODO

> **FOR HUMANS ONLY** — This is a reference document, not a task list to be executed.
> AI agents: do not action any item in this file unless explicitly instructed by the user
> to work on a specific item.

## Git Multi-Account Setup (personal + work)

Both accounts require explicit input — no silent default.

- [ ] Generate two SSH keys: `~/.ssh/id_ed25519_personal` and `~/.ssh/id_ed25519_work`
- [ ] Add both public keys to their respective GitHub accounts
- [ ] Create `~/.ssh/config` (or track it in dotfiles) with two explicit aliases:
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
  Always clone using the alias (`git@github.personal:...` or `git@github.work:...`),
  never bare `github.com`.
- [ ] Split git user identity into two files:
  - `git/gitconfig-personal` — name + personal email (`mdlerch@gmail.com`)
  - `git/gitconfig-work` — name + work email
  - Remove `[user]` block from main `gitconfig` so Git forces a per-repo or per-file identity
    (Git will error on commit if no identity is set, which is the desired explicit behavior)

---

## gitconfig

- [ ] Add `[init] defaultBranch = main`
- [ ] Add `[fetch] prune = true` (auto-removes stale remote-tracking branches)
- [ ] Update `unadd` alias: `reset HEAD` → `restore --staged` (modern Git)
- [ ] Remove duplicate alias — `tracked` and `istracked` are identical; drop one
- [ ] Rename `diff = "diff --check"` — overrides `git diff` default behavior; rename to
      something like `check` or `ws` (whitespace check)
- [ ] Fix `[gist] home` path — currently `/home/mike/work/gists/` (Linux); update to macOS path
      or remove if gist CLI is no longer used
- [ ] Check if `git/ghi.gitconfig` is still used — `ghi` (GitHub Issues CLI) was abandoned;
      remove the `[include]` for it if so
- [ ] Consider `nvimdiff` for `[merge] tool` since you're on Neovim

---

## zsh/zshrc

- [x] **Remove `export TERM="xterm-256color"` override** — modern macOS terminals set this
      correctly; overriding can mask a better value (e.g. `xterm-ghostty`, `alacritty`)
- [x] **Fix `autoload -z edit-command-line`** → `autoload -Uz edit-command-line`; the `,,`
      vi-mode escape works but the `edit-command-line` keybinding has a garbled/empty sequence —
      set an explicit key like `^X^E`
- [x] **Remove SVN from vcs_info**: `zstyle ':vcs_info:*' enable git` (drop `svn`)
- [x] **Fix compinit**: change to `autoload -Uz compinit && compinit -C` (`-Uz` is standard;
      `-C` skips security check on subsequent shells for faster startup)
- [x] **Fix virtualenvwrapper path** — `/usr/bin/virtualenvwrapper.sh` is a Linux path, silently
      fails on macOS; update path or remove if not using virtualenvwrapper
- [x] **Add history improvements**:
  - Increase `SAVEHIST` (e.g. `100000`) — should be larger than `HISTSIZE`
  - Add `setopt SHARE_HISTORY` or `INC_APPEND_HISTORY` (share history across concurrent shells)
- [x] **Consider `atuin` for history** — SQLite-backed history replacement; records timestamp,
      directory, exit code, and session per command; great fuzzy TUI (replaces Ctrl+R); handles
      multiple tmux panes elegantly; can sync across machines. `brew install atuin`, then one
      init line in zshrc. Pairs well with existing fzf workflow.
- [x] **Add `export EDITOR=nvim`**
- [x] **Add `/opt/homebrew/bin` to PATH** if not set elsewhere (e.g. in `~/.zprofile`)

---

## zsh/alias.zsh

**Delete — broken on macOS:**
- [ ] `alias open='xdg-open'` — **BREAKS macOS `open` command**; delete immediately
- [ ] `alias ugaussfs='fusermount -u ...'` — `fusermount` is Linux-only; delete

**Fix:**
- [ ] `alias sshfs='.../Cellar/sshfs-fuse-t/2026.05.12-cebbdd3/bin/sshfs'` — hardcoded Cellar
      path breaks on any `brew upgrade`; change to `/opt/homebrew/bin/sshfs` or remove alias
      and rely on PATH

**Delete — dead Linux/X11 leftovers:**
- [ ] `alias n='urxvtc &'` — rxvt-unicode terminal, X11 only
- [ ] `alias skype='xhost +local: && sudo -u skype /usr/bin/skype'` — old Linux Skype workaround

**Delete — old MSU servers/services (almost certainly dead):**
- [ ] `alias newton` / `alias newtonx`
- [ ] `alias gauss` / `alias gaussx` / `alias mgaussfs`
- [ ] `alias euclid` / `alias meuclidfs`
- [ ] `alias knox` / `alias knoxcareer`

**Cleanup:**
- [ ] Remove all commented-out `rsync*` aliases
- [ ] Remove commented-out `NVIM_TUI_ENABLE_TRUE_COLOR=1` aliases (env var deprecated; Neovim
      auto-detects true color)
- [ ] Remove dead `if [ "$HOST" == "WF12611" ]` comment block around `ls` aliases
- [ ] `alias ovim` — Vim client-server mode; remove if not using it
- [ ] `alias cmus="player"` — aliases the app name to a different command; clarify or remove

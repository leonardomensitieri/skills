# Memory

Installs two things into your `~/.claude/`, working together:

- **`SessionStart` hook** — on every session, in every project, symlinks that project's auto-memory folder to `./memory` at the root. In a git repo, it adds `/memory` to `.git/info/exclude` (local, never committed). Silent, idempotent, never blocks the session.
- **Memory protocol** — three rules in your `~/.claude/CLAUDE.md`: preview + pre-approval, grill before saving, and progressive capture.

```bash
bash setup/memory/install.sh
```

Requires `jq`. In a project without git, the exclude step is skipped. Idempotent — re-running never duplicates anything. To undo: remove the `hooks.SessionStart` block from `settings.json` (or restore the `.bak`), delete the hook, and remove the `## Memory` and `## Environment` sections from `CLAUDE.md`.

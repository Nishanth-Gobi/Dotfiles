# claude

Global Claude Code config. Layered scope intent:

| Scope | Path | Purpose |
| ----- | ---- | ------- |
| User (global) | `~/.claude/` | Cross-project tools, preferences |
| Project (shared) | `<repo>/.claude/` | Codebase-specific, committed |
| Project (local) | `<repo>/.claude/settings.local.json` | Per-machine overrides, gitignored |

This module ships the global scope.

## What's stowed

- `CLAUDE.md` — global preferences (code style, workflow)
- `settings.json` — permission allowlist + agent toggles (see below)
- `skills/` — hand-picked skills from [mattpocock/skills](https://github.com/mattpocock/skills): `caveman`, `grill-me`, `grill-with-docs`, `handoff`

## What's NOT stowed

Runtime state (transcripts, sessions, plugin cache, paste cache, telemetry) stays as real dirs under `~/.claude/`. `.gitignore` uses allowlist pattern so future Claude versions can add new runtime paths without leaking into the repo.

## Stow quirk: `--no-folding`

`~/.claude/` is shared with runtime writes, so `install.sh` passes `--no-folding` for this module only. Without it, stow would symlink the whole `~/.claude` → repo and runtime writes would land in the repo. With it, individual children (`settings.json`, `CLAUDE.md`, `skills/*`) get linked, and `~/.claude` stays a real dir.

## CLAUDE.md

```markdown
--8<-- "claude/.claude/CLAUDE.md"
```

## settings.json

```json
--8<-- "claude/.claude/settings.json"
```

### What each entry does

| Key | Effect |
| --- | --- |
| `permissions.allow: Bash(npm run lint)`, `Bash(bun run lint)` | Pre-authorize lint runs. Exact-match patterns — no args allowed, intentionally. Lint shouldn't need arguments at this level. |
| `permissions.allow: Bash(npm run test:*)`, `Bash(bun run test:*)` | Pre-authorize test runs with any args (`:*` matches "command + any trailing args"). Lets Claude scope tests (e.g. `npm run test -- path/to/file`) without prompting. |
| `permissions.deny: Read(.env)`, `Read(.env.*)`, `Read(**/.env)`, `Read(**/.env.*)` | Hard block on reading dotenv files anywhere in the tree. Prevents accidental secret exfiltration to a model context. Deny rules override allow rules. |
| `skipDangerousModePermissionPrompt: true` | Suppress the one-time confirmation when entering dangerous mode (bypass-all-prompts). Opted in once, globally. |
| `remoteControlAtStartup: true` | Enable the remote control feature at session start — lets the claude.ai web app drive the local CLI session. |
| `agentPushNotifEnabled: true` | Allow agents to push notifications (desktop / phone via Claude app) when long-running work completes. |

#### Permission pattern syntax cheatsheet

- `Bash(cmd)` — exact match. No args.
- `Bash(cmd:*)` — `cmd` followed by any args. The `:*` suffix is the documented "command + arbitrary trailing args" pattern.
- `Read(path)` — exact path match relative to cwd. No `./` prefix.
- `Read(glob)` — glob match. `**/` for recursive, `*` for single-segment wildcard.

### What's not in here

- **Hooks.** The old Superset notification hooks (gated by `$SUPERSET_HOME_DIR`) were removed once that tool fell out of use.
- **Plugin enablement.** The `caveman` plugin was disabled when the mattpocock `caveman` skill replaced it. Skill files in `skills/` are simpler to manage than plugin install metadata.
- **Secrets / per-machine overrides.** Belong in `~/.claude/settings.local.json` (gitignored). Don't add machine-specific paths or tokens to the stowed `settings.json`.

# Editor Philosophy

The portable spec for my editor setup. This file is the source of truth.
Implementations (Zed, Neovim, Cursor, VS Code) are translations of it.

When trying a new editor, read this top-to-bottom and translate section by
section. The thinking is done; only the JSON/Lua/keymap dialect changes.

---

## The three categories

1. **Editor settings** — non-keybinding preferences (tabs, formatting, scan
   exclusions, line numbers, theme). Mostly universal, easiest to port.
2. **Code keybindings** — how I manipulate text. For me this is "vim motions."
   One-line spec, every modern editor has a vim mode.
3. **Navigation keybindings** — how I move around the editor itself (file
   tree, finder, terminal, git, panels). LazyVim-flavored leader namespaces.
   This is the section that makes a new editor feel like home.

---

## Section 1: Editor Settings

### 1.1 Indentation & formatting

- Default: **2-wide hard tabs** (real `\t`, visual width 2)
- Per-language overrides where the ecosystem demands it:
  - **Python**: 4-wide spaces (PEP 8)
  - **YAML**: 2-wide spaces (YAML spec forbids tabs)
  - **Markdown**: 2-wide spaces (cross-renderer consistency)
  - **JSON / JSONC**: 2-wide spaces (prettier convention)
  - **Go**: 4-wide hard tabs (gofmt convention)
- **Format on save**: on, using project's configured formatter
- **Trim trailing whitespace** + **ensure final newline** on save
- **Per-language formatters, never global** (biome for JS/TS, ruff for
  Python, gofmt for Go, prettier for JSON/Markdown/YAML; let the LSP
  handle everything else)
- **Respect `.editorconfig`** automatically — project beats personal

### 1.2 Visual display

- **Vim mode**: on
- **Relative line numbers**: on (counting jumps is faster than reading absolutes)
- **Soft wrap**: off (wide monitors; wrapping hides structure)
- **Cursor blink**: off (less visual noise)
- **Whitespace rendering**: selection only (clean view)
- **Font**: JetBrains Mono, 15pt buffer, 16pt UI
- **Theme**: Gruvbox, following system light/dark

### 1.3 Editor chrome

Minimal. Hide what doesn't earn its pixels.

- **Scrollbars**: never
- **Tab bar**: visible, with file icons + git status, no nav-history buttons
- **Toolbar quick actions**: off
- **Indent guides**: on, indent-aware coloring
- **Project panel**: file icons + folder icons + git status, no scrollbar

### 1.4 File scanning & search scope

- Exclude noise from project scans: `node_modules`, build outputs (`dist`,
  `build`, `target`, `.next`, `.turbo`, `coverage`), caches (`.venv`,
  `__pycache__`, `.pytest_cache`, `.ruff_cache`), VCS metadata, OS junk
- Force-include `.env*` files (gitignored but I need to see them)
- **Gotcha**: in most editors, scan-exclusion lists *replace* defaults
  rather than appending. When adding to the list, include the editor's
  defaults too or they vanish.

### 1.5 Save & session behavior

- **Autosave**: on focus change (good enough for vim users who sometimes
  forget `:w`; doesn't fight muscle memory the way "on keystroke" does)
- **Trust all worktrees** — don't prompt on every project open

### 1.6 AI & agents

- **Primary agent**: Claude Code (via ACP where supported, or terminal-native)
- **Secondary**: Codex / others as registry entries
- **Inline edit predictions**: enabled, but skip generated/vendor/IDE dirs
  (build outputs, node_modules, caches, `.git`, `.idea`, `.vscode`)

### 1.7 Privacy

- **Telemetry**: off (diagnostics + metrics)

### 1.8 Editor-specific bucket

Things that don't translate to other editors. Document them with a comment
explaining why, so future-me knows what to skip when porting.

Examples for Zed: `base_keymap` choice — currently set to the editor's
closest match to my preferences (JetBrains for Zed), with the long-term
goal of `None`. See §3.6 for the migration strategy.

---

## Section 2: Code Keybindings

**Vim motions.** That's the entire spec.

Every modern editor has a vim mode worth using. Enable it. Don't customize
motion bindings — universal vim is the portable contract.

What I rely on coming for free from vim mode:

- Motions: `hjkl`, `w/b/e`, `0/$/^`, `gg/G`, counts (`3dd`), `f/t`, `/?nN`, `*#`, `%`
- Text objects: `iw/aw`, `i"/a"`, `ip/ap`, `it/at`, `i{/a{`
- Operators: `d/c/y/v` + any motion or text object
- Modes: normal, insert, visual (char/line/block), command, operator-pending
- Marks (`ma`, `'a`), registers (`"ay`), macros (`qa…q@a`), `.` repeat

And from the editor's LSP integration via vim convention (these "just work,"
no explicit bindings needed):

- `K` — hover documentation
- `gd` / `gD` — go to definition / declaration
- `gr` — references
- `gi` — implementations
- `gy` — type definition
- `]d` / `[d` — next / previous diagnostic
- `]c` / `[c` — next / previous git hunk
- `<C-o>` / `<C-i>` — jump back / forward in history

If an editor's vim mode is missing any of these, that's a signal the vim
mode isn't good enough — don't paper over it with custom bindings, find a
better vim implementation.

---

## Section 3: Navigation Keybindings

Two tiers. Keep them separate; they have different roles.

### 3.1 Universal chords (no vim required)

Work everywhere, every context, regardless of mode. These are the lifelines
and the "I'm not thinking about it" muscle memory.

| Chord            | Action                          | Notes                          |
|------------------|---------------------------------|--------------------------------|
| `cmd-shift-p`    | Command palette                 | The lifeline. Always-on.       |
| `shift shift`    | File finder (search everywhere) | JetBrains-style                |
| `` cmd-` ``      | Toggle bottom dock (terminal)   | Universal across all editors   |
| `cmd-1`          | Toggle left dock (file tree)    | Number-indexed docks port well |
| `cmd-2`          | Toggle right dock (AI/agent)    |                                |

### 3.2 Leader namespaces (vim mode only)

Leader = `<space>`. Grouped by mnemonic. LazyVim-aligned so bindings
transfer to Neovim 1:1.

| Namespace       | Purpose                | Examples                                |
|-----------------|------------------------|-----------------------------------------|
| `<leader><spc>` | Quick file finder      | most-used; no submenu                   |
| `<leader>e`     | Toggle file explorer   | three-state: open+focus / focus / close |
| `<leader>f…`    | **F**ind (known things)| `ff` files, `fr` recent, `fn` new file  |
| `<leader>s…`    | **S**earch (discover)  | `sg` grep, `ss` symbols, `sd` diagnostics |
| `<leader>g…`    | **G**it                | `gg` lazygit                            |
| `<leader>b…`    | **B**uffers            | `bd` delete, `bn` next, `bp` prev       |
| `<leader>w…`    | **W**indows/splits     | `wv` vsplit, `ws` hsplit, `wc` close    |
| `<leader>c…`    | **C**ode (LSP only)    | `cf` format, `ca` action, `cr` rename   |
| `<leader>q…`    | **Q**uit               | `qq` quit                               |

Note the **f/s split**: `f` is for things you know exist and want to
navigate to; `s` is for content discovery. `<leader>ff` = "open this file,"
`<leader>sg` = "find me code mentioning this string."

### 3.3 Bracket-pair navigation

Vim convention: `]x` next, `[x` previous, for any "x."

- `] d` / `[ d` — diagnostics
- `] b` / `[ b` — buffers
- `] c` / `[ c` — git hunks (free from vim mode)

### 3.4 File tree (project panel) bindings

Vim-native `hjkl` + LazyVim-style single-letter ops:

- `h` collapse, `l` expand, `j/k` next/prev, `-` parent, `enter` open
- `a` new file, `A` new dir, `r` rename, `d` delete
- `x/c/p` cut/copy/paste, `/` search-in-directory, `:` command palette
- `escape` return focus to editor

### 3.5 The panel-toggle pattern

Three-state toggles (hidden → open+focus, focused → close) are rarely a
single action. The portable pattern is **two bindings, layered by context**:

1. Outer context (workspace/editor): bind chord to *open and focus* the
   panel (e.g. `ActivatePanel`)
2. Inner context (when panel is focused): bind same chord to *close* the
   panel (e.g. `ToggleDock`)

Context layering produces the toggle behavior. No plugin or composite
action needed. This pattern ports directly to VS Code (when/context
bindings), Cursor (inherits), and Neovim (autocommands).

### 3.6 Base keymap: destination, not starting point

`None` (no base keymap, every chord explicit) is the goal, but starting
there means hitting unmapped chords for weeks while building muscle memory
from scratch. Bad migration path. Instead:

1. **Start with the base whose defaults you genuinely prefer**, not the
   "neutral" one. For me that's JetBrains in Zed (IntelliJ-style chords:
   `cmd-b` go-to-def, `shift-shift` search-everywhere, `F2` next-error,
   `alt-enter` quick-fix). VSCode is the "neutral" choice if you have no
   preference; pick what your fingers already know.

2. **Treat collisions as curriculum, not friction.** Every time a base
   default fights one of your bindings, you have a productive moment:
   the conflict tells you which defaults you've outgrown. Two responses:

   - **Override**: bind the conflicted chord to your action explicitly,
     scoped to the context where the conflict happens (usually `Editor`).
     Higher-specificity context + your binding wins over the base default.
   - **Null it out**: bind to `null` to suppress the default without
     replacing it. Trains muscle memory away from the chord entirely.

3. **Diagnose with the key context view.** When a chord misbehaves,
   command palette → `dev: open key context view`. Press the chord and
   see every binding that matched, with their context specificity. The
   one marked `(match)` is what fired; `(low precedence)` ones lost.
   Authoritative debugger; never guess.

4. **Migrate gradually.** Each override is permanent keymap that survives
   the eventual flip to `None`. Each null-out is a default you've decided
   to abandon. When you can read your `keymap.json` end-to-end and say
   "this covers every chord I use," flip `base_keymap` to `None` — your
   overrides become your only bindings, your null-outs disappear (no
   base default to suppress), and nothing changes about your daily flow.

The point: don't optimize for "intentional from day one." Optimize for
"intentional by month six, with no productivity gap during migration."

---

## Translation checklist for new editors

When configuring a new editor, walk through this in order:

1. **Vim mode on.** If the editor's vim mode is weak, reconsider the editor.
2. **Section 1.1–1.8** → translate to the editor's settings format,
   one subsection at a time, with comment headers matching this doc.
3. **Section 2** → confirm motions + LSP-via-vim all work. Note any gaps.
4. **Section 3.1** → bind the five universal chords. These come first
   because they're the lifelines.
5. **Section 3.2** → translate leader namespaces. Bind only the chords
   you've actually used in the last month; the rest is theater.
6. **Section 3.3–3.5** → bracket pairs, file tree, panel toggle pattern.
7. **Code for an hour.** Note every chord you reach for that isn't bound.
   Bind those next. Repeat until the gap list goes empty.

The first translation of this doc to a new editor takes ~30 minutes.
Subsequent re-translations take ~10. The reading takes 60 seconds.

---

## Maintenance

This file is the spec. Editor configs are derivations. When the spec
changes (new principle, new chord, new pattern), update *this file first*,
then propagate to editor configs. Never let an editor config drift ahead
of the philosophy — that's how you end up debugging in three configs at
once with no source of truth.

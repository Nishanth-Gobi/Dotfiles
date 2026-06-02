# Global preferences

## Code style
- No comments unless absolutely necessary. `// TODO:` to flag future work is fine.
- Functional: composable, pure, immutable, single-purpose. Pipelines over imperative loops where idiomatic.

## Workflow
- Before touching unfamiliar code, run `grill-me` or `grill-with-docs` to confirm understanding of the existing model.
- Boy-scout: context-free cleanup only (renames, dead code, obvious extracts). Commit the refactor. Tests green before and after.
- Lay out the full planned commit sequence for the task (big picture) for review before writing code.
- Structural refactors that only make sense in light of the task land as their own commit at the front of the plan (Fowler preparatory refactor).
- Logically atomic commits — one logical unit per commit.
- Hotfix / on-call: skip grill and refactor, fix forward, refactor later.
- Never run `git commit`. Stage as needed, then propose the commit command (HEREDOC for multi-line bodies) and stop. User runs it.

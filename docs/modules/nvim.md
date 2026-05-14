# nvim

[LazyVim](https://www.lazyvim.org/) starter + custom plugin tweaks.

## Entry point

```lua
--8<-- "nvim/.config/nvim/init.lua"
```

## LazyVim extras

```json
--8<-- "nvim/.config/nvim/lazyvim.json"
```

## Plugin overrides

### Explorer

```lua
--8<-- "nvim/.config/nvim/lua/plugins/explorer.lua"
```

### TypeScript

```lua
--8<-- "nvim/.config/nvim/lua/plugins/typescript.lua"
```

## Plugin lockfile

Track [`lazy-lock.json`](https://github.com/Nishanth-Gobi/Dotfiles/blob/main/nvim/.config/nvim/lazy-lock.json)
for reproducible plugin versions across machines (same idea as
`package-lock.json`).

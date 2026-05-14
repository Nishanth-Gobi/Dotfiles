# zsh

XDG-compliant: `ZDOTDIR=$HOME/.config/zsh`. Plugins are git submodules.

## Layout

```text
zsh/.config/zsh/
├── .zshrc           # main rc, sourced after .zshenv
├── zsh-aliases     # alias definitions
├── host.zsh        # machine-specific (gitignored)
└── plugins/
    ├── fzf-tab/
    ├── gitstatus/
    ├── zsh-autosuggestions/
    └── zsh-syntax-highlighting/
```

## .zshrc

```bash
--8<-- "zsh/.config/zsh/.zshrc"
```

## Aliases

```bash
--8<-- "zsh/.config/zsh/zsh-aliases"
```

## .zshenv (loaded first, lives in `$HOME`)

```bash
--8<-- "home/.zshenv"
```

## Updating plugins

```sh
git submodule update --remote --merge
```

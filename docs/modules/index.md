# Modules

Each module is a [GNU Stow](https://www.gnu.org/software/stow/) package.
Adding a new one:

```sh
mkdir -p mytool/.config/mytool
mv ~/.config/mytool/* mytool/.config/mytool/
stow -d ~/dotfiles/Dotfiles -t ~ mytool
```

Then append `mytool` to the `COMMON_MODULES` (or `MACOS_MODULES`) array in
[install.sh](https://github.com/Nishanth-Gobi/Dotfiles/blob/main/install.sh).

## Live module pages

Module pages embed live config via the `pymdownx.snippets` extension —
edit a config file, push, the site auto-updates. No duplication.

# git

Personal git identity + XDG-aware ignore rules. Multi-identity via
`includeIf` for work repos under `~/work/`.

## config

```ini
--8<-- "git/.config/git/config"
```

## Work identity (machine-local, not tracked)

The `[includeIf "gitdir:~/work/"]` block loads `~/.config/git/work.local`
when you're inside any repo under `~/work/`. Create that file locally —
do **not** commit it to dotfiles:

```ini
# ~/.config/git/work.local
[user]
    name = Work Name
    email = work@company.com
    signingkey = ~/.ssh/id_git_signing_sk.pub
[commit]
    gpgsign = true
[gpg]
    format = ssh
[gpg "ssh"]
    allowedSignersFile = ~/.config/git/work.allowed_signers
```

Also create `~/.config/git/work.allowed_signers` with one line per allowed
signer (email + SSH pubkey). Both files stay machine-local.

Any repo at `~/work/foo/` → uses work identity + signing.
Anywhere else → uses personal identity, no signing.

## Global ignore

```text
--8<-- "git/.config/git/ignore"
```

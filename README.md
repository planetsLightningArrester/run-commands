# Run Commands (*rc files) 💻


Repository with centralized and scalable `rc` files

> Many functions rely on the fact that this repo is inside your `$HOME/run-commands` directory. The behavior may be unexpected otherwise.

# Motivation ✨

Every now and then I come up with a new alias. Then I have to change that on the `.cshrc` and `.bashrc` in all sites. To ease this process, I keep my `rc` files inside `~/run-commands` and source them in my original `rc` files. A plus is to have all of them tracked and synced!

99% based on [The Ultimate Bad Ass .bashrc File](https://gist.github.com/zachbrowne/8bc414c9f30192067831fafebd14255c).

## FAQ
* *Q:* Why not track the original `rc` files?
  * *A*: Because my home directory is huge and takes ~70s to just run `git status`.

# Functions 🦾

Some functions below. Not all functions and aliases are documented. You can play with the functions in this [Notebook](https://github.com/planetsLightningArrester/run-commands/tree/main/notebooks/docs/functions/functions.ipynb)!

```bash
# machine: Get machine status
$~ > machine _
# CPU Usage: 5.6133%
# Memory Usage: 4451/7823MB (56.90%)
# Disk Usage: 11/20GB (54%)

# mkdirg: Make dir and move into it
$~ > mkdirg vhdl _
$~/vhdl > _

# up: Go up as much as needed
$~/vhdl/lp/design/rtl > up 3 _
$~/vhdl > _

# new: Crete a new file and required paths
$~ > new lp/design/rtl/top.v _

# newo: Crete a new file and open in editor
$~ > newo lp/design/rtl/top.v _

# x: Extract any archive
$~ > x my.tar.gz
$~ > x my.gz
$~ > x my.tar
$~ > x my.zip
$~ > x my.tgz

# cpp: Copy with progress bar
$~ > cpp design.tar.gz ~
# design.tar.gz  43% [===========>            ] | 6 s

# ftext: Find text in the current dir
$~/run-commands > ftext bashrc
# ./README.md:44:  . "$HOME/run-commands/.bashrc";
# ./.bashrc:13:[[ -f /etc/bashrc ]] && . /etc/bashrc
# ./aliases/common:19:set-alias rebash 'source $HOME/.bashrc'
# ./aliases/common:23:set-alias ebash '$EDITOR "$HOME/run-commands/.bashrc"'
```

> Functions that, e.g., change the current dir are required to be `source`d. Those have the extension `.s` under `functions/`. But the aliases remove the file extension

# Usage 📚

1. Since you'd probably have your own aliases and env settings, forking this repo and changing it to better suit your needs seems to be the best approach. Otherwise, clone this repo into your home directory
```bash
cd ~
git clone git@github.com:planetsLightningArrester/run-commands.git
```
2. Backup your `rc`s!
3. Link your `.bashrc`, `.cshrc`, and other `rc`s of interest
```bash
ln -sf ~/run-commands/.cshrc ~/.cshrc
ln -sf ~/run-commands/.bashrc ~/.bashrc
```
4. Change the cloned/forked `rc` files as you wish. But notice
    1. Many functions rely on the fact that this repo is inside your `$HOME/run-commands` directory. The behavior may be unexpected otherwise.
    2. Private aliases and envs are automatically source from `aliases/.$USER` and `env/.$USERS`. You can base on mines (`aliases/.ubuntu`).
    3. All files (except `./prompt`) are made to be cross-shell. So use:
      1. `test` command for conditional control
      2. `setenv`/`unsetenv` to set env vars (I made this supported by `bash` by creating the function `./functions/setenv`)
      3. `set-alias` instead of ~`alias`~ to set aliases
5. Change your `/.*rc` to source the `/run-commands/.*rc`. Example of `.bashrc` below, but the same applies to the `.cshrc`.
```bash
#!/bin/bash

. "$HOME/run-commands/.bashrc";

# EOF
```
6. If you forked the repo, now you can keep track of your changes across the sites!
7. I made the function `pushrc <message>` available out-of-the-box to easily sync your local changes
8. `functions/` are all written in bash
9. For the rest of `rc`s, you can link them in your home
  1. > cd ~ && ln -sf ~/run-commands/.vimrc
  2. > cd ~ && ln -sf ~/run-commands/.tmux.conf
  3. > cd ~ && ln -sf ~/run-commands/.tmux.conf.local
  4. > cd ~ && ln -sf ~/run-commands/.screenrc
  5. > cd ~ && ln -sf ~/run-commands/.Xdefaults
  6. > cd ~ && ln -sf ~/run-commands/.Xresources

# Issues 🐛
Please report issues [here](https://github.com/planetsLightningArrester/run-commands/issues)

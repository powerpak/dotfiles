# powerpak's dotfiles

## Auto install

`git clone` into `~/dotfiles` (or `~/.dotfiles`), `cd` into the repo, and run `rake`.

## Manual installation

In general, `git clone` into `~/dotfiles` (or `~/.dotfiles`), then symlink as needed into `~`

### For fancy screen:

You need to symlink `.screenrc` and `.screen-profiles`, and symlink `bin/screen-profiles-status` into your `~/bin`

If you want to change the logo, create `.screen-profiles/logo`

### For htop without meters for all CPUs:

Most useful on machines with >32 cores, in which case htop becomes a wall of meters without a process list. Symlink `~/.config/htop/htoprc` to this repo's version; beware that htop automatically saves new changes every time you quit gracefully with F10 (not Ctrl-C).

### For .bash_profile:
>>>>>>> 164d9bfd71deb55f2727255fdb63458f670b69da

Don't symlink; instead, edit existing `.bashrc` or `.bash_profile`, and add:

    source dotfiles/.bash_profile

Then set the color of the prompt and the hostname by adding:

    export PSCOLOR=$COLOR_(BLACK|CYAN|BLUE|RED|GRAY|BROWN|GREEN|PURPLE)
    export PSHOST="computah"

If you want the hostname portion to be bold or underlined, set

    export PSBOLD=1

or

    export PSUNDERLINE=1

respectively.

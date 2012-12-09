powerpak's dotfiles
===================

In general:
-----------

`git clone` into `~/dotfiles` (or `~/.dotfiles`), then symlink as needed into `~`

For fancy screen:
-----------------

You need to symlink `.screenrc` and `.screen-profiles`, and make sure
`bin/screen-profiles-status` is in `$PATH`

If you want to change the logo, create `.screen-profiles/logo`

For .bash_profile:
------------------

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

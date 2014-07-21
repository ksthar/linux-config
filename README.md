linux-config
============

Common config files for my bash-based Linux/BSD systems.

Installation
------------

The idea is that I can clone this repo on a new system and create symlinks in
my home directory to the config files here.  I *could* just create a home
directory repo, but everything gets dumped there and I would need to work with
my ignore file.  This seems simpler at the moment.

Simlinks:
- .bashrc
- .vimrc
- .vim/
- .tmux.conf
- .tmux/
- .pentadactylrc
- .pentadactyl/
- .conkyrc

Linux vs. FreeBSD
-----------------

I use both Linux systems and FBSD systems.  I plan to create a FBSD fork to
handle differences (e.g. to color ls in FBSD, you use the -G flag instead of
--color=auto, etc.).  There may be distro-specific differences that would
effect my scripts (e.g. ifconfig formatting) that would require additional
forks as well. **OR** if there are few enough files, I could include all here
and just symlink to the ones I want.

Cygwin
------
I have added support for Cygwin.  The .bashrc file checks for a cywin install
(uname -o) to customize.  This is a possible solution to the Linux/FBSD issue
as well, but has not been implemented yet.

Vim
---

I have included the CSApprox (for terminal vim colorschemes) in the .vim
directory.  On Ubuntu, the CSApprox.vim plugin file was missing a statement
that setup the Normal highlight causing a runtime error.  The included version
has the patch installed.

I have also included the jellybeans colorscheme file.  This will need to be
moved to /usr/share/vim/vim7x/colors/ or wherever your distro installs
colorschemes.  Currently, .vimrc sets this as the default.

NOTES
-----

I might need to chuck this and start over.  This is a test.


TO-DO
-----
Create an install script that creates the symlinks in the new system.

linux-config
============

Common config files for my bash-based Linux/BSD systems.  Clone into home
directory and symlink to the desired files and directories.

Installation
------------
The idea is that I can clone this repo on a new system, create symlinks in my
home directory, and have a familiar setup very quickly.  This can be automated
on vagrant or docker systems.  One limitation is that this is not a protected
repo so I have to be careful about the contents of the files I share.  For now,
bitlbee and mutt files are not included for that reason.

Simlink to home dir:
- .bashrc
- .conkyrc
- .elinks/
- .irssi/
- .ncmpc/
- .ncmpcpp/
- .pentadactylrc
- .pentadactyl/
- .tmux.conf
- .tmux/
- .vimrc
- .vim/

Linux vs. FreeBSD
-----------------
I use both Linux systems and FBSD systems.  For now, I'm using 'uname -o' to
adapt my .bashrc file.  I have not handled the difference in bash locations
(/bin/bash (linux) vs. /usr/local/bin/bash (FreeBSD)), so some scripts will not
run without modification (the right.sh script for tmux, for example).  Also,
the output of some common tools (e.g. ifconfig) is different causing
strangeness when scripts expect a certain format.

Cygwin
------
I have added support for Cygwin.  The .bashrc file checks for a cygwin install
(uname -o) to customize.  Cygwin also has a custom dircolors setup (linked
through .minttyrc) that should be run on new installs.

ncmpcpp
-------
This is handy to keep in a tmux session.  I use it in conjunction with MPD, and
have not included those configs.  I prefer this to ncmpc, but have included
ncmpc for now.

Irssi
-----
Irssi is my Grand Central station for non-email communications.  I run
everything through it. Necessary scripts are in .irssi/scripts.

### Bitlbee for Chat
Bitlbee should be installed.  I have not included my .bitlbee/ directory and
.bitlbee.conf file.  Scrubbed versions are required.  Note that when you launch
bitlbee, include the full paths: 

	bitlbee -c /full/path/.bitlbee.conf -d /full/path/.bitlbee 

Bitlbee is great for all XMPP-based chat services.  For HipChat support, check
out the [bitlbee docs](http://wiki.bitlbee.org/HowtoHipchat).

### 256 Color Support
Awhile back, I found a [256 color patch]
(https://aur.archlinux.org/packages/irssi-256color/) for irssi on Arch.  I really like
the flexibility of 256 colors, but I have had issues with the patch.  The
adv\_windowlist.pl and twirssi.pl scripts behaved differently when run in a
patched version of irssi.  Consequently, I've dropped back to plain 'ol 16
colors.  Default theme is hars16.theme.  It actually works ok with the cygwin
dircolors or by using Tango colors in gnome-terminal with cyan modified to
\#4e4e4e (dark \#3a3a3a).

### Twitter Solution
Twirssi has worked better than bitlbee's twitter support and has more features.

Tmux
----
This setup expects a v1.8 or better.  Ubuntu 12.04 runs ~v1.6 and will choke on
a couple settings.  Also, the right.sh expects /bin/bash, curl, and specific
output from ifconfig.

Vim
---
I have included the CSApprox (for terminal vim colorschemes) in the .vim
directory.  On Ubuntu, the CSApprox.vim plugin file was missing a statement
that setup the Normal highlight causing a runtime error.  The included version
has the patch installed.

I have also included the jellybeans colorscheme file.  This will need to be
moved to /usr/share/vim/vim7x/colors/ or wherever your distro installs
colorschemes.  Currently, .vimrc sets this colorscheme as the default.

TO-DO
-----
- Create an install script that creates the symlinks in the new system.
- Adapt shell scripts to different bash locations
- Adapt scripts to different utility outputs
- ?Scrub bitlbee conf and dir
- ?Add mutt: scrub files 

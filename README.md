# linux-config

This repo contains common config files for my bash-based Linux/BSD systems.
The idea is that I can clone this repo on a new system, install my favorite
programs, create symlinks in my home directory, and have a familiar setup very
quickly.  I use several machines throughout the day and may instantiate a vm or
two on-the-fly.  Having a quick way to standardize an environment is very
handy.

Effort has been made to make the experience consistent across Linux, BSD, Mac,
and Windows (Cygwin).  Not everything will run seemlessly on all platforms, but
a bash shell should be consistent in look and feel.

## NOTES 
- It's good to keep in mind that all the files are copied onto every system.  I
  have err'd on the side of better-to-have-it, but there is a limit here
  somewhere.
- This is a public repo so I have to be careful about leaking too much personal
  information.  For now, bitlbee and mutt files are not included for that
  reason.  Separate private repos have been setup for irssi and mutt.
- Some files/directories are included for specific alias sets that I 'source'
  selectively on certain systems.
- Installation can be automated on vagrant or docker systems. Handy. 
- The jellybeans colorscheme for vim is the inspiration for many of the custom
  color adjustments in these files.
- Enough applications are supported here to configure a simple desktop with
  chat/IRC, browsing, text/code editing, music, and session support.

## Some Systems That Should "Just Work"
- Ubuntu 12/14/15
- FreeBSD 9/10/11
- OpenBSD 5.4/5.8
- Yocto
- Mac OS X
- Windows 7/8/10 (Cygwin)

## Installation
_Directions:_
- Ensure sudo is installed and the user has sudo privileges
- Ensure the user is running bash
    $ cd $HOME
    $ git clone https://github.com/ksthar/linux-config.git
    $ ./linux-config/install_<os>.sh

_Ubuntu Example:_

    $ cd 
    $ sudo apt-get -y install git
    $ git clone https://github.com/ksthar/linux-config
    $ ./linux-config/install_ubuntu.sh
    (follow prompts)


_Available Configs:_
- .bashrc
- .bitlbee (PRIVATE)
- .bitlbee.conf (PRIVATE)
- .conkyrc
- .elinks/
- .i3/
- .irssi/ (PRIVATE)
- .minttyrc
- .mintty--solarized-mod
- .mutt/ (PRIVATE)
- .ncmpc/
- .ncmpcpp/
- .pentadactylrc
- .pentadactyl/
- .tmux/
- .tmux.conf
- .vimrc
- .vim/
- jellybeans.vim
- README.md

### Linux vs. FreeBSD
I use both Linux systems and FBSD systems.  For now, I'm using variations of
'uname' to adapt my .bashrc file. In the install\_freebsd.sh script, I symlink
/usr/local/bin/bash to /bin/bash so that my linux-style bash scripts will work.

### Cygwin
I have added support for Cygwin.  The .bashrc file checks for a cygwin install
(uname -o) to customize.  Cygwin also has a custom dircolors setup (linked
through .minttyrc) that should be run on new installs.

### Mac OSX
I have added some support for Terminal on the Mac. The .bashrc file should
detect (uname -s) and adjust.

## Application Support
### conky
Custom conky config included.

### elinks
The elinks config file is included.  Some files like bookmarks, cookies, and
history files have been excluded.

### i3
This is the first window manager supported here.  The config file has a
customized color scheme and some adjustments to the standard commands.

### Irssi
*NOTE: irssi-config now a private repo*
Irssi is my Grand Central station for non-email communications.  I run
everything through it. Necessary scripts are in .irssi/scripts.

#### Irssi: Bitlbee for Chat
Bitlbee should be installed.  I have not included my .bitlbee/ directory and
.bitlbee.conf file.  Scrubbed versions are required.  Note that when you launch
bitlbee, include the full paths: 

    $ bitlbee -c /full/path/.bitlbee.conf -d /full/path/.bitlbee 

Bitlbee is great for all XMPP-based chat services.  For HipChat support, check
out the [bitlbee docs](http://wiki.bitlbee.org/HowtoHipchat).

#### Irssi: 256 Color Support
Awhile back, I found a [256 color patch]
(https://aur.archlinux.org/packages/irssi-256color/) for irssi on Arch.  I really like
the flexibility of 256 colors, but I have had issues with the patch.  The
adv\_windowlist.pl and twirssi.pl scripts behaved differently when run in a
patched version of irssi.  Consequently, I've dropped back to plain 'ol 16
colors.  Default theme is hars16.theme.  It actually works ok with the cygwin
dircolors or by using Tango colors in gnome-terminal with cyan modified to
\#4e4e4e (dark \#3a3a3a).

#### Irssi: Use Twirssi
Twirssi has worked better than bitlbee's twitter support and has more features.

### Mutt
*All mutt configs now in private mutt-config repo.*

### ncmpcpp
This is handy to keep in a tmux session.  I use it in conjunction with MPD, and
have not included those configs.  I prefer this to ncmpc, but have included
ncmpc for now.

### Tmux
This setup expects a v1.8 or better.  Ubuntu 12.04 runs ~v1.6 and will choke on
a couple settings.  Also, the right.sh expects /bin/bash, curl, and specific
output from ifconfig.

### Vim
I have included the CSApprox (for terminal vim colorschemes) in the .vim
directory.  On Ubuntu 12.04, the CSApprox.vim plugin file was missing a
statement that setup the Normal highlight causing a runtime error.  The
included version has the patch installed.

I have also included the jellybeans colorscheme file.  This has been included
in .vim/colors/, but may need to be moved to /usr/share/vim/vim7x/colors/ (or
wherever your distro installs colorschemes) on some systems.  Currently, .vimrc
sets this colorscheme as the default.

Some systems contain a version of vim than does not recognize the 'j' format
option.  I just delete it for those systems.

I have configured vim to use .vim/tmp for swap and backup files.  This helps
keep git repos clear of vim artifacts.

The install scripts will attempt to install several plugins for vim from github.  

## TO-DO
- [DONE] Create an install script that creates the symlinks in the new system.
- [DONE] Adapt shell scripts to different bash locations (/bin/bash vs. /usr/local/bin/bash)
- [DONE] Adapt scripts to different utility outputs (e.g. ifconfig outputs differently
  on some systems)
- [DONE] Create a 'supported application' list
- [DONE] Create bundles for specific distros (install scripts)
- [DONE] Scrub bitlbee conf and dir (created private repos for sensitive configs)
- [DONE] Add mutt: scrub files  (see prev)
- ?Create 'light' and 'complete' branches if this one gets too heavy
- ?Create 'laptop' and 'workstation' branches

## EOF

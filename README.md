linux-config
============

Common config files for my bash-based Linux/BSD systems.

Installation
------------

The idea is that I can clone this repo on a new system and create symlinks in
my home directory to the config files here.  I *could* just create a home
directory repo, but everything gets dumped there and I would need to work with
my ignore file.  This seems simpler at the moment.

Linux vs. FreeBSD
-----------------

I use both Linux systems and FBSD systems.  I plan to create a FBSD fork to
handle differences (e.g. to color ls in FBSD, you use the -G flag instead of
--color=auto, etc.).  There may be distro-specific differences that would
effect my scripts (e.g. ifconfig formatting) that would require additional
forks as well. **OR** if there are few enough files, I could include all here
and just symlink to the ones I want.


NOTES
-----

I might need to chuck this and start over.  This is a test.

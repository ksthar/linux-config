irssi
=====
I use irssi for all non-email communications: primarily chat and twitter.  For chat, use bitlbee.  It can connect to all XMPP based chat services including GTalk, jabber, and HipChat.  For twitter, use twirssi.  It has more features than bitlbee's twitter support.

irssi 256 Color Notes
=====================
- The patch sequence is found in the PKGBUILD script.  Check out the configure parameters as well: you'll want --prefix, but the others are optional.
- The twirssi.pl script doesn't work with 256 color patched irssi.  I don't know why, but it complains that it can't determine the local time zone.  Wierd, and I don't have time to find root cause.
- The adv_windowlist.pl script chokes on 256 colors as well.  It parses the longer color strings (e.g. %z3a3a3a) and counts the characters as part of the block.  What you see is a channel list that doesn't seem to reach across the statusbar--it doesn't think it has room.
- You can get close to a 256 color look by setting dircolors.  Change your cyan to gray...

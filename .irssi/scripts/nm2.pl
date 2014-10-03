use Irssi;
use strict;
use v5.14;
use List::Util qw(max);

our $VERSION="0.3.10.3";
our %IRSSI = (
	authors=> 'BC-bd',
	contact=> 'bd@bc-bd.org',
	name=> 'nm',
	description=> 'right aligned nicks depending on longest nick',
	license=> 'GPL v2',
	url=> 'http://bc-bd.org/blog/irssi/',
);

# nm2 Version 0.3.10.3
# - custom modified by Nei. this variant which does right align per
#   channel instead of globally and shortens aggressively.
#
# use a ** nickcolor_expando ** for nick colors!

#
# $Id$
# nm.pl
# for irssi 0.8.4 by bd@bc-bd.org
#
# right aligned nicks depending on longest nick
#
# inspired by neatmsg.pl from kodgehopper <kodgehopper@netscape.net
# formats taken from www.irssi.de
# thanks to adrianel <adrinael@nuclearzone.org> for some hints
# thanks to Eric Wald <eswald@gmail.com> for the left alignment patch
# inspired by nickcolor.pl by Timo Sirainen and Ian Peters
# thanks to And1 <and1@meinungsverstaerker.de> for a small patch
# thanks to berber@tzi.de for the save/load patch
# thanks to Dennis Heimbert <dennis.heimbert@gmail.com> for a bug report/patch
#
#########
# OPTIONS
#########

my $help = "
/set neat_left_actions <ON|OFF>
    * ON  : print nicks left-aligned on actions
    * OFF : print nicks right-aligned on actions

/set neat_left_messages <ON|OFF>
    * ON  : print nicks left-aligned on messages
    * OFF : print nicks right-aligned on messages

/set neat_right_mode <ON|OFF>
    * ON  : print the mode of the nick e.g @%+ after the nick
    * OFF : print it left of the nick 

/set neat_maxlength <number>
    * number : Maximum length of Nicks to display. Longer nicks are truncated.
    * 0      : Do not truncate nicks.

/set neat_melength <number>
    * number : number of spaces to substract from /me padding

/set neat_history <number>
    * number : number of formatted lines to remember
 
";

#
###
################
###
#
# Changelog
#
# Version 0.3.10
#  - fix losing of saved color when changing nick shares more than one channel
#    with you
#
# Version 0.3.9
#  - fix longest nick calculation for nicks shorter than the current longest
#    nick
#  - updated url
#
# Version 0.3.8
#  - fixed error in the nickchange tracking code, reported by Kevin Ballard
#  - added --all switch to reset command
#  - skip broken lines in saved_colors
#
# Version 0.3.7
#  - fixed crash when calling /neatcolor without parameters
#  - fixed url
#
# Version 0.3.6
#  - added option to ignore certain characters from color hash building, see
#    https://bc-bd.org/trac/irssi/ticket/22
#  - added option to save and specify colors for nicks, see
#    https://bc-bd.org/trac/irssi/ticket/23
#  - added option to disallow shrinking, see
#    https://bc-bd.org/trac/irssi/ticket/12
#
# Version 0.3.5
#  - now also aligning own messages in queries
#
# Version 0.3.4
#  - fxed off by one error in nick_to_color, patch by jrib, see
#  https://bc-bd.org/trac/irssi/ticket/24
#
# Version 0.3.3
#  - added support for alignment in queries, see
#    https://bc-bd.org/trac/irssi/ticket/21
#
# Version 0.3.2
#  - integrated left alignment patch from Eric Wald <eswald@gmail.com>, see
#    https://bc-bd.org/trac/irssi/ticket/18
#
# Version 0.3.1
#  - /me padding, see https://bc-bd.org/trac/irssi/ticket/17
#
# Version 0.3.0
#  - integrate nick coloring support
#
# Version 0.2.1
#  - moved neat_maxlength check to reformat() (thx to Jerome De Greef <jdegreef@brutele.be>)
#
# Version 0.2.0
#  - by adrianel <adrinael@nuclearzone.org>
#     * reformat after setup reload
#     * maximum length of nicks
#
# Version 0.1.0
#  - got lost somewhere
#
# Version 0.0.2
#  - ugly typo fixed
#  
# Version 0.0.1
#  - initial release
#
###
################
###
#
# BUGS
#
# Empty nicks, eg "<> message"
# 	This seems to be triggered by some themes. As of now there is no known
# 	fix other than changing themes, see
# 	https://bc-bd.org/trac/irssi/ticket/19
#
# Well, it's a feature: due to the lacking support of extendable themes
# from irssi it is not possible to just change some formats per window.
# This means that right now all windows are aligned with the same nick
# length, which can be somewhat annoying.
# If irssi supports extendable themes, I will include per-server indenting
# and a setting where you can specify servers you don't want to be indented
#
###
################

my ($sign, $actsign, %commands, %histories, %S);

my $colorize;

sub init_hist {
    my ($server, $target) = @_;
    if (my $ch = $server->channel_find($target)) {
	[ max map { length } map { $_->{nick} } $ch->nicks ]
    }
    else {
	[ max map { length } $server->{nick}, $target ]
    }
}

sub reformat {
    my ($mode, $server, $target, $nick) = @_;
    my $tg = $server->{tag};
    my $hist = $histories{"$tg/$target"} ||= init_hist($server, $target);
    my $last = $histories{"$tg/$target/last"} || 1;
    unshift @$hist, length $nick;
    if (@$hist > 2*$S{history}) {
	splice @$hist, $S{history};
    }
    my $longestNick = $histories{"$tg/$target/last"} = max(@$hist, $last - 1);

    if ($S{max} && $S{max} < $longestNick) {
	$longestNick = $S{max};
    }

    my $me = max(0, $longestNick - $S{melength});
    my $melength = $actsign . $me;
    my $length = $sign . $longestNick;

    if ($mode == 5) {
	Irssi::command('^format own_action {ownaction $['.$melength.']0}$1');
    }
    elsif ($mode == 4) {
	Irssi::command('^format action_public {pubaction $['.$melength.']0}$1');
	Irssi::command('^format action_private {pvtaction $['.$melength.']0}$1');
	Irssi::command('^format action_private_query {pvtaction_query $['.$melength.']0} $2');
    }
    elsif ($mode == 3) {
	Irssi::command('^format own_msg_private_query {ownprivmsgnick {ownprivnick $['.$length.']2}}$1');
    }
    elsif ($mode == 2) {
	Irssi::command('^format msg_private_query {privmsgnick $['.$length.']0}$2');
    }
    elsif ($mode == 1) {
	unless ($S{right_mode}) {
	    Irssi::command('^format own_msg {ownmsgnick $2 {ownnick $['.$length.']0}}$1');
	    Irssi::command('^format own_msg_channel {ownmsgnick $3 {ownnick $['.$length.']0}{msgchannel $1}}$2');
	}
	else {
	    Irssi::command('^format own_msg {ownmsgnick {ownnick $['.$length.']0$2}}$1');
	    Irssi::command('^format own_msg_channel {ownmsgnick {ownnick $['.$length.']0$3}{msgchannel $1}}$2');
	}
    }
    elsif ($mode == 0) {
	unless ($S{right_mode}) {
	    Irssi::command('^format pubmsg_me {pubmsgmenick $2 {menick $['.$length.']0}}$1');
	    Irssi::command('^format pubmsg_me_channel {pubmsgmenick $3 {menick $['.$length.']0}{msgchannel $1}}$2');
	    Irssi::command('^format pubmsg_hilight {pubmsghinick $0 $3 $['.$length.']1%n}$2');
	    Irssi::command('^format pubmsg_hilight_channel {pubmsghinick $0 $4 $['.$length.']1{msgchannel $2}}$3');
	    if ($colorize) {
		Irssi::command('^format pubmsg {pubmsgnick $2 {pubnick $nickcolor$['.$length.']0}}$1');
		Irssi::command('^format pubmsg_channel {pubmsgnick $3 {pubnick $nickcolor$['.$length.']0}{msgchannel $1}}$2');
	    }
	    else {
		Irssi::command('^format pubmsg {pubmsgnick $2 {pubnick $['.$length.']0}}$1');
		Irssi::command('^format pubmsg_channel {pubmsgnick $3 {pubnick $['.$length.']0}{msgchannel $1}}$3');
	    }
	} else {
	    Irssi::command('^format pubmsg_me {pubmsgmenick {menick $['.$length.']0}$2}$1');
	    Irssi::command('^format pubmsg_me_channel {pubmsgmenick {menick $['.$length.']0$3}{msgchannel $1}}$2');
	    Irssi::command('^format pubmsg_hilight {pubmsghinick $0 $0 $['.$length.']1$3%n}$2');
	    Irssi::command('^format pubmsg_hilight_channel {pubmsghinick $0 $0 $['.$length.']1$4{msgchannel $2}}$3');
	    if ($colorize) {
		Irssi::command('^format pubmsg {pubmsgnick {pubnick $nickcolor$['.$length.']0$2}}$1');
		Irssi::command('^format pubmsg_channel {pubmsgnick {pubnick $nickcolor$['.$length.']0$3}{msgchannel $1}}$2');
	    }
	    else {
		Irssi::command('^format pubmsg {pubmsgnick {pubnick $['.$length.']0$2}}$1');
		Irssi::command('^format pubmsg_channel {pubmsgnick {pubnick $['.$length.']0$3}{msgchannel $1}}$2');
	    }
	}
    }
}

sub sig_setup {
    $S{history} = Irssi::settings_get_int('neat_history');
    $S{max} = Irssi::settings_get_int('neat_maxlength');
    $S{melength} = Irssi::settings_get_int('neat_melength');
    $actsign = Irssi::settings_get_bool('neat_left_actions')? '': '-';
    $sign = Irssi::settings_get_bool('neat_left_messages')? '': '-';

    # check left or right alignment
    $S{right_mode} = Irssi::settings_get_bool('neat_right_mode');

    # check if we switched coloring on or off
    $colorize = Irssi::settings_get_bool('neat_colorize');
}

# log a line to a window item
sub neat_log {
    my ($witem, @text) = @_;

    $witem->print("nm2.pl: ".$_) foreach(@text);
}

Irssi::settings_add_bool('misc', 'neat_left_messages', 0);
Irssi::settings_add_bool('misc', 'neat_left_actions', 0);
Irssi::settings_add_bool('misc', 'neat_right_mode', 1);
Irssi::settings_add_int('misc', 'neat_maxlength', 0);
Irssi::settings_add_int('misc', 'neat_melength', 2);
Irssi::settings_add_bool('misc', 'neat_colorize', 1);
Irssi::settings_add_int('misc', 'neat_history', 50);

Irssi::signal_add('setup changed', 'sig_setup');
Irssi::signal_add_last('setup reread', 'sig_setup');

Irssi::signal_add_first({
    'message public' => sub {
	my ($server, $msg, $nick, $address, $target) = @_;
	reformat(0, $server, $target, $nick);
    },
    'message own_public' => sub {
	my ($server, $msg, $target) = @_;
	reformat(1, $server, $target, $server->{nick});
    },
    'message private' => sub {
	my ($server, $msg, $nick, $address) = @_;
	reformat(2, $server, $nick, $nick);
    },
    'message own_private' => sub {
	my ($server, $msg, $target) = @_;
	reformat(3, $server, $target, $server->{nick});
    },
    'message irc action' => sub {
	my ($server, $msg, $nick, $address, $target) = @_;
	reformat(4, $server, $target, $nick);
    },
    'message irc own_action' => sub {
	my ($server, $msg, $target) = @_;
	reformat(5, $server, $target, $server->{nick});
    }
   });
Irssi::signal_add_last({
    'channel destroyed' => sub {
	my ($channel) = @_;
	delete $histories{ $channel->{server}{tag} . '/' . $channel->{name} };
	delete $histories{ $channel->{server}{tag} . '/' . $channel->{name} . '/last' };
    },
    'query destroyed' => sub {
	my ($query) = @_;
	delete $histories{ $query->{server}{tag} . '/' . $query->{name} };
	delete $histories{ $query->{server}{tag} . '/' . $query->{name} . '/last' };
    },
    'query nick changed' => sub {
	my ($query, $old_nick) = @_;
	delete $histories{ $query->{server}{tag} . '/' . $old_nick };
	delete $histories{ $query->{server}{tag} . '/' . $old_nick . '/last' };
    },
    'query server changed' => sub {
	my ($query, $old_server) = @_;
	delete $histories{ $old_server->{tag} . '/' . $query->{name} };
	delete $histories{ $old_server->{tag} . '/' . $query->{name} . '/last' };
    }
   });
sig_setup;

#########################################################################
#  OpenKore - Packet sending
#  This module contains functions for sending packets to the server.
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
#
#  $Revision: 6687 $
#  $Id: kRO.pm 6687 2009-04-19 19:04:25Z technologyguild $
########################################################################
# Korea (kRO)
# The majority of private servers use eAthena, this is a clone of kRO

package Network::Send::kRO::Sakexe_2004_09_06a;

use strict;
use base qw(Network::Send::kRO::Sakexe_2004_08_17a);

sub version {
	return 10;
}

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);
	
	my %packets = (
		'0072' => ['item_use', 'x7 a2 x9 a4', [qw(ID targetID)]],#24 Here is error, the packet length should be 20
		'007E' => ['storage_item_add', 'x a2 x10 V', [qw(ID amount)]],
		'0085' => ['actor_action', 'x7 a4 x9 C', [qw(targetID type)]],
		'0089' => ['character_move', 'x4 a3', [qw(coords)]],
		'008C' => ['skill_use_location_text', 'v x8 v x2 v x2 v x3 v Z80', [qw(lvl ID x y info)]],
		'009B' => ['actor_info_request', 'x8 a4', [qw(ID)]],
		'0094' => ['item_drop', 'x4 a2 x7 v', [qw(ID amount)]],
		'009F' => ['public_chat', 'x2 Z*', [qw(message)]],
		'00A2' => ['actor_name_request', 'x8 a4', [qw(ID)]],
		'00A7' => ['skill_use_location', 'x8 v x2 v x2 v x3 v', [qw(lv skillID x y)]],
		'00F3' => ['actor_look_at', 'x2 C x4 C', [qw(head body)]],
		'00F5' => ['map_login', 'x5 a4 x4 a4 x6 a4 V C', [qw(accountID charID sessionID tick sex)]],
		'00F7' => ['storage_close'],
		'0113' => ['item_take', 'x5 a4', [qw(ID)]],
		'0116' => ['sync', 'x5 V', [qw(time)]],
		'0190' => ['skill_use', 'x7 V x2 v x a4', [qw(lv skillID targetID)]],#22
		'0193' => ['storage_item_remove', 'x a2 x8 V', [qw(ID amount)]],
	);
	
	$self->{packet_list}{$_} = $packets{$_} for keys %packets;
	
	my %handlers = qw(
		actor_action 0085
		actor_info_request 009B
		actor_look_at 00F3
		actor_name_request 00A2
		character_move 0089
		item_take 0113
		item_drop 0094
		item_use 0072
		map_login 00F5
		public_chat 009F
		skill_use 0190
		skill_use_location 00A7
		storage_item_add 007E
		storage_item_remove 0193
		sync 0116
		skill_use_location_text 008C
		storage_close 00F7
	);
	
	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
	
	return $self;
}

1;

=pod
//2004-09-06aSakexe
packet_ver: 10
0x0072,20,useitem,9:20
0x007e,19,movetokafra,3:15
0x0085,23,actionrequest,9:22
0x0089,9,walktoxy,6
0x008c,105,useskilltoposinfo,10:14:18:23:25
0x0094,17,dropitem,6:15
0x009b,14,getcharnamerequest,10
0x009f,-1,globalmessage,2:4
0x00a2,14,solvecharname,10
0x00a7,25,useskilltopos,10:14:18:23
0x00f3,10,changedir,4:9
0x00f5,34,wanttoconnection,7:15:25:29:33
0x00f7,2,closekafra,0
0x0113,11,takeitem,7
0x0116,11,ticksend,7
0x0190,22,useskilltoid,9:15:18
0x0193,17,movefromkafra,3:13
=cut
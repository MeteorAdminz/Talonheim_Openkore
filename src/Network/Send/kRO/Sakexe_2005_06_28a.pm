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

package Network::Send::kRO::Sakexe_2005_06_28a;

use strict;
use base qw(Network::Send::kRO::Sakexe_2005_06_22a);

sub version {
	return 17;
}

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);
	
	my %packets = (
		'0072' => ['skill_use', 'x4 V x7 v x11 a4', [qw(lv skillID targetID)]],#34
		'007E' => ['skill_use_location_text', 'v x10 v x v x v x11 v Z80', [qw(lvl ID x y info)]],
		'0085' => ['actor_look_at', 'x6 v x6 C', [qw(head body)]],
		'0089' => ['sync', 'x7 V', [qw(time)]],
		'008C' => ['actor_info_request', 'x2 a4', [qw(ID)]],
		'0094' => ['storage_item_add', 'x14 a2 x9 V', [qw(ID amount)]],
		'009B' => ['map_login', 'x7 a4 x2 a4 x4 a4 V C', [qw(accountID charID sessionID tick sex)]],
		'009F' => ['item_use', 'x7 a2 x4 a4', [qw(ID targetID)]],#19
		'00A2' => ['actor_name_request', 'x3 a4', [qw(ID)]],
		'00A7' => ['character_move', 'x6 a3', [qw(coords)]],
		'00F5' => ['item_take', 'x7 a4', [qw(ID)]],
		'00F7' => ['storage_item_remove', 'x9 a2 x V', [qw(ID amount)]],
		'0113' => ['skill_use_location', 'x10 v x v x v x11 v', [qw(lv skillID x y)]],
		'0116' => ['item_drop', 'x a2 x5 v', [qw(ID amount)]],
		'0190' => ['actor_action', 'x9 a4 x8 C', [qw(targetID type)]],
	);
	
	$self->{packet_list}{$_} = $packets{$_} for keys %packets;
	
	my %handlers = qw(
		skill_use_location_text 007E
	);
	
	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
	
	return $self;
}

1;

=pod
//2005-06-28aSakexe
packet_ver: 17
0x0072,34,useskilltoid,6:17:30
0x007e,113,useskilltoposinfo,12:15:18:31:33
0x0085,17,changedir,8:16
0x0089,13,ticksend,9
0x008c,8,getcharnamerequest,4
0x0094,31,movetokafra,16:27
0x009b,32,wanttoconnection,9:15:23:27:31
0x009f,19,useitem,9:15
0x00a2,9,solvecharname,5
0x00a7,11,walktoxy,8
0x00f5,13,takeitem,9
0x00f7,18,movefromkafra,11:14
0x0113,33,useskilltopos,12:15:18:31
0x0116,12,dropitem,3:10
0x0190,24,actionrequest,11:23
0x0216,0
0x023d,-1
0x023e,4
=cut
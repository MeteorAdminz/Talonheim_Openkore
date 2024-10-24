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
########################################################################

package Network::Send::kRO::RagexeRE_2015_12_30a;

use strict;
use base qw(Network::Send::kRO::RagexeRE_2015_12_02);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);

	my %packets = (
		'0369' => ['actor_action', 'a4 C', [qw(targetID type)]],
		'096A' => ['actor_info_request', 'a4', [qw(ID)]],
		'0869' => ['actor_look_at', 'v C', [qw(head body)]],
		'0368' => ['actor_name_request', 'a4', [qw(ID)]],
		'0811' => ['buy_bulk_buyer', 'v a4 a4 a*', [qw(len buyerID buyingStoreID itemInfo)]], #Buying store
		'0817' => ['buy_bulk_closeShop'],
		'0436' => ['buy_bulk_openShop', 'v V C Z80 a*', [qw(len limitZeny result storeName itemInfo)]], # Buying store
		'0360' => ['buy_bulk_request', 'a4', [qw(ID)]], #6
		'0437' => ['character_move', 'a3', [qw(coordString)]],
		'088E' => ['friend_request', 'a*', [qw(username)]],# len 26
		'0949' => ['homunculus_command', 'v C', [qw(commandType commandID)]],
		'0897' => ['item_drop', 'a2 v', [qw(ID amount)]],
		'085B' => ['item_list_window_selected', 'v V V a*', [qw(len type act itemInfo)]],
		'094E' => ['item_take', 'a4', [qw(ID)]],
		'0815' => ['map_login', 'a4 a4 a4 V C', [qw(accountID charID sessionID tick sex)]],
		'0861' => ['party_join_request_by_name', 'Z24', [qw(partyName)]],
		'083C' => ['skill_use', 'v2 a4', [qw(lv skillID targetID)]],
		'0886' => ['skill_use_location', 'v4', [qw(lv skillID x y)]],
		'02C4' => ['storage_item_add', 'a2 V', [qw(ID amount)]],
		'091D' => ['storage_item_remove', 'a2 V', [qw(ID amount)]],
		'0923' => ['storage_password'],
		'035F' => ['sync', 'V', [qw(time)]],
		'0819' => ['search_store_info', 'v C V2 C2 a*', [qw(len type max_price min_price item_count card_count item_card_list)]],
		'0835' => ['search_store_request_next_page'],
		'0838' => ['search_store_select', 'a4 a4 v', [qw(accountID storeID nameID)]],
	);

	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
		actor_action 0369
		actor_info_request 096A
		actor_look_at 0869
		actor_name_request 0368
		buy_bulk_buyer 0811
		buy_bulk_closeShop 0817
		buy_bulk_openShop 0436
		buy_bulk_request 0360
		character_move 0437
		friend_request 088E
		homunculus_command 0949
		item_drop 0897
		item_list_window_selected 085B
		item_take 094E
		map_login 0815
		party_join_request_by_name 0861
		skill_use 083C
		skill_use_location 0886
		storage_item_add 02C4
		storage_item_remove 091D
		storage_password 0923
		sync 035F
		search_store_info 0819
		search_store_request_next_page 0835
		search_store_select 0838
	);



	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;

##if PACKETVER == 20151230
###packetKeys(0x54C51241,0x33883499,0x3CDA35F0);
#	$self->cryptKeys(0x54C51241, 0x3CDA35F0, 0x33883499);

	return $self;
}

1;

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
#bysctnightcore
package Network::Send::kRO::RagexeRE_2016_04_14b;

use strict;
use base qw(Network::Send::kRO::RagexeRE_2016_03_02b);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);

	my %packets = (
		'0369' => ['actor_action', 'a4 C', [qw(targetID type)]],
		'096A' => ['actor_info_request', 'a4', [qw(ID)]],
		'0922' => ['actor_look_at', 'v C', [qw(head body)]],
		'0368' => ['actor_name_request', 'a4', [qw(ID)]],
		'0811' => ['buy_bulk_buyer', 'v a4 a4 a*', [qw(len buyerID buyingStoreID itemInfo)]], #Buying store
		'0817' => ['buy_bulk_closeShop'],
		'0815' => ['buy_bulk_openShop', 'v V C Z80 a*', [qw(len limitZeny result storeName itemInfo)]], # Buying store
		'0360' => ['buy_bulk_request', 'a4', [qw(ID)]], #6
		'0437' => ['character_move', 'a3', [qw(coordString)]],
		'0945' => ['friend_request', 'a*', [qw(username)]],# len 26
		'0934' => ['homunculus_command', 'v C', [qw(commandType commandID)]],
		'0931' => ['item_drop', 'a2 v', [qw(ID amount)]],
		'0362' => ['item_list_window_selected', 'v V V a*', [qw(len type act itemInfo)]],
		'0363' => ['item_take', 'a4', [qw(ID)]],
		'0862' => ['map_login', 'a4 a4 a4 V C', [qw(accountID charID sessionID tick sex)]],
		'089E' => ['party_join_request_by_name', 'Z24', [qw(partyName)]],
		'083C' => ['skill_use', 'v2 a4', [qw(lv skillID targetID)]],
		'0438' => ['skill_use_location', 'v4', [qw(lv skillID x y)]],
		'0953' => ['storage_item_add', 'a2 V', [qw(ID amount)]],
		'0885' => ['storage_item_remove', 'a2 V', [qw(ID amount)]],
		'0927' => ['storage_password'],
		'035F' => ['sync', 'V', [qw(time)]],
		'0819' => ['search_store_info', 'v C V2 C2 a*', [qw(len type max_price min_price item_count card_count item_card_list)]],
		'0835' => ['search_store_request_next_page'],
		'0838' => ['search_store_select', 'a4 a4 v', [qw(accountID storeID nameID)]],
	);

	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
		actor_action 0369
		actor_info_request 096A
		actor_look_at 0922
		actor_name_request 0368
		buy_bulk_buyer 0811
		buy_bulk_closeShop 0817
		buy_bulk_openShop 0815
		buy_bulk_request 0360
		character_move 0437
		friend_request 0945
		homunculus_command 0934
		item_drop 0931
		item_list_window_selected 0362
		item_take 0363
		map_login 0862
		party_join_request_by_name 089E
		skill_use 083C
		skill_use_location 0438
		storage_item_add 0953
		storage_item_remove 0885
		storage_password 0927
		sync 035F
		search_store_info 0819
		search_store_request_next_page 0835
		search_store_select 0838
	);



	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;
#	elif PACKETVER == 20160414 // 2016-04-14bRagexeRE
#		packet_keys(0x31BD479A,0x40C61398,0x397C1A80);
#	$self->cryptKeys(0x31BD479A,0x397C1A80 ,0x40C61398);


	return $self;
}

1;

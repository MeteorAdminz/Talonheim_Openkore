#########################################################################
#  OpenKore - Network subsystem
#  This module contains functions for sending messages to the server.
#
#  This software is open source, licensed under the GNU General Public
#  License, version 2.
#  Basically, this means that you're allowed to modify and distribute
#  this software. However, if you distribute modified versions, you MUST
#  also distribute the source code.
#  See http://www.gnu.org/licenses/gpl.html for the full license.
#########################################################################
# pRO Thor as of December 1 2006
# paddedPackets_attackID 0x008C
# paddedPackets_skillUseID 0x007E
# syncID 0x0190
# syncTickOffset 5
# mapLoadedTickOffset 7
# Servertype overview: https://openkore.com/wiki/ServerType
package Network::Send::ServerType14;

use strict;
use Network::Send::ServerType0;
use Network::PaddedPackets;
use base qw(Network::Send::ServerType0);

use Globals qw($char $masterServer $syncSync);
use Log qw(debug);
use I18N qw(stringToBytes);
use Utils qw(getTickCount getHex getCoordString);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new(@_);

	my %packets = (
		'0116' => ['storage_close'],
	);

	$self->{packet_list}{$_} = $packets{$_} for keys %packets;

	my %handlers = qw(
		storage_close 0116
	);

	$self->{packet_lut}{$_} = $handlers{$_} for keys %handlers;

	return $self;
}

sub sendAction {
	my ($self, $monID, $flag) = @_;
	$self->sendToServer(Network::PaddedPackets::generateAtk($monID, $flag));
	debug "Sent Action: " .$flag. " on: " .getHex($monID)."\n", "sendPacket", 2;
}
=pod
sub sendSit {
	my ($self) = @_;
	$self->sendToServer(Network::PaddedPackets::generateSitStand(1));
	debug "Sitting\n", "sendPacket", 2;
}

sub sendStand {
	my ($self) = @_;
	$self->sendToServer(Network::PaddedPackets::generateSitStand(0));
	debug "Standing\n", "sendPacket", 2;
}
=cut

sub sendDrop {
	my ($self, $index, $amount) = @_;
	my $msg;

	$msg = pack("C2 v1 v1", 0xA7, 0x00, $index, $amount);

	$self->sendToServer($msg);
	debug "Sent drop: $index x $amount\n", "sendPacket", 2;
}

sub sendGetPlayerInfo {
	my ($self, $ID) = @_;
	my $msg;
	$msg = pack("C*", 0xA2, 0x00) . pack("x1") . $ID;
	$self->sendToServer($msg);
	debug "Sent get player info: ID - ".getHex($ID)."\n", "sendPacket", 2;
}

sub sendItemUse {
	my ($self, $ID, $targetID) = @_;
	my $msg;

	$msg = pack("C2 v1", 0xF5, 0x00, $ID) .
		$targetID;

	$self->sendToServer($msg);
	debug "Item Use: $ID\n", "sendPacket", 2;
}

sub sendLook {
	my ($self, $body, $head) = @_;
	my $msg;

	$msg = pack("C4 x1", 0x93, 0x01, $body, $head);

	$self->sendToServer($msg);
	debug "Sent look: $body $head\n", "sendPacket", 2;
	$char->{look}{head} = $head;
	$char->{look}{body} = $body;
}

sub sendMapLogin {
	my ($self, $accountID, $charID, $sessionID, $sex) = @_;
	my $msg;
	$sex = 0 if ($sex > 1 || $sex < 0); # Sex can only be 0 (female) or 1 (male)

	$msg = pack("C*", 0x9F, 0x00) .
		$accountID .
		pack("x3") .
		$charID .
		pack("V", getTickCount()) .
		pack("x9") .
		$sessionID .
		pack("x1") .
		pack("C*", $sex) .
		pack ("x2");

	$self->sendToServer($msg);
}

sub sendMove {
	my $self = shift;
	my $x = int scalar shift;
	my $y = int scalar shift;
	my $msg;

	$msg = pack("C2 x3", 0x94, 0x00) . getCoordString($x, $y, 1);

	$self->sendToServer($msg);
	debug "Sent move to: $x, $y\n", "sendPacket", 2;
}

sub sendSkillUse {
	my ($self, $ID, $lv, $targetID) = @_;
	$self->sendToServer(Network::PaddedPackets::generateSkillUse($ID, $lv,  $targetID));
	debug "Skill Use: $ID\n", "sendPacket", 2;
}

sub sendChat {
	my ($self, $message) = @_;
	$message = "|00$message" if $masterServer->{chatLangCode};

	my ($data, $charName); # Type: Bytes
	$message = stringToBytes($message); # Type: Bytes
	$charName = stringToBytes($char->{name});

	$data = pack("C*", 0x85, 0x00) .
		pack("v*", length($charName) + length($message) + 8) .
		$charName . " : " . $message . chr(0);

	$self->sendToServer($data);
}

sub sendSkillUseLoc {
	my ($self, $ID, $lv, $x, $y) = @_;
	my $msg;

	$msg = pack("v1 v1 v1 x5 v1 v1", 0xF7, $lv, $ID, $x, $y);

	$self->sendToServer($msg);
	debug "Skill Use on Location: $ID, ($x, $y)\n", "sendPacket", 2;
}

sub sendStorageAdd {
	my ($self, $index, $amount) = @_;
	my $msg;

	$msg = pack("C2 x2 a2 V1", 0x13, 0x01, $index, $amount);

	$self->sendToServer($msg);
	debug "Sent Storage Add: $index x $amount\n", "sendPacket", 2;
}

sub sendStorageGet {
	my ($self, $index, $amount) = @_;
	my $msg;

	$msg = pack("C2 V1 a2 x2", 0x9B, 0x00, $amount, $index);

	$self->sendToServer($msg);
	debug "Sent Storage Get: $index x $amount\n", "sendPacket", 2;
}

sub sendSync {
	my ($self, $initialSync) = @_;
	my $msg;
	# XKore mode 1 lets the client take care of syncing.
	return if ($self->{net}->version == 1);

	$syncSync = pack("V", getTickCount());
	$msg = pack("C2 x3", 0x90, 0x01) . $syncSync . pack("x5");

	$self->sendToServer($msg);
	debug "Sent Sync\n", "sendPacket", 2;
}

sub sendTake {
	my ($self, $itemID) = @_;
	my $msg;
	$msg = pack("C2", 0x72, 0x00) . $itemID;
	$self->sendToServer($msg);
	debug "Sent take\n", "sendPacket", 2;
}

1;

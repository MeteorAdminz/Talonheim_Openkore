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

package Network::Send::kRO::Sakexe_2005_10_13a;

use strict;
use base qw(Network::Send::kRO::Sakexe_2005_10_10a);

sub new {
	my ($class) = @_;
	return $class->SUPER::new(@_);
}

=pod
//2005-10-13aSakexe
0x007a,6
0x0251,32
0x025c,4,auctionbuysell,0
=cut

1;
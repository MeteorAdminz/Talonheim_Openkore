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

package Network::Send::kRO::Sakexe_2004_11_09a;

use strict;
use base qw(Network::Send::kRO::Sakexe_2004_11_01a);

sub new {
	my ($class) = @_;
	return $class->SUPER::new(@_);
}

=pod
//2004-11-08aSakexe
0x0084,2
0x0216,6
0x0217,2,blacksmith,0
0x0218,2,alchemist,0
0x0219,282
0x021a,282
0x021b,10
0x021c,10
=cut

1;
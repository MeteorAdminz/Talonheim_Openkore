# euRO (Europe) as of December 20 2006
# Servertype overview: https://openkore.com/wiki/ServerType
package Network::Receive::ServerType16;

use strict;
use Network::Receive::ServerType11;
use base qw(Network::Receive::ServerType11);

sub new {
	my ($class) = @_;
	my $self = $class->SUPER::new;
	return $self;
}

1;

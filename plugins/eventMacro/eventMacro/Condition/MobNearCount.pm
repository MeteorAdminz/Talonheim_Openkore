package eventMacro::Condition::MobNearCount;

use strict;
use Globals qw( $monstersList );
use base 'eventMacro::Condition::Base::ActorNearCount';

sub _hooks {
	my ( $self ) = @_;
	my $hooks = $self->SUPER::_hooks;
	my @other_hooks = ('add_monster_list','monster_disappeared');
	push(@{$hooks}, @other_hooks);
	return $hooks;
}

sub _get_val {
	my ( $self ) = @_;
	return ($monstersList->size + $self->{change});
}

sub validate_condition {
	my ( $self, $callback_type, $callback_name, $args ) = @_;
	if ($callback_type eq 'hook' && $callback_name eq 'monster_disappeared') {
		$self->{change} = -1;
	} else {
		$self->{change} = 0;
	}
	return $self->SUPER::validate_condition( $callback_type, $callback_name, $args );
}


1;

package Bot::BasicBot::Pluggable::Module::GoogleWeather;

use strict;
use utf8;
use Bot::BasicBot::Pluggable::Module;
use base qw(Bot::BasicBot::Pluggable::Module);

use Weather::Google;

sub said {
    my ( $self, $mess, $pri ) = @_;

    my $body = $mess->{body};
    my $who  = $mess->{who};

    return unless $body =~ /^\s*(weather|forecast)\s+(?:for\s+)?(.*?)\s*\?*\s*$/;

    my $type = $1;
    my $code = $2;

    my $gw = new Weather::Google($code) || return "Could not found $code";

    return sprintf(
        "Forecast %s for %s %s/%s°C %s", $code, $gw->forecast( 1, 'day_of_week' ), int( ( $gw->forecast( 1, 'low' ) - 32 ) * 5 / 9 ),
        int( ( $gw->forecast( 1, 'high' ) - 32 ) * 5 / 9 ),
        $gw->forecast( 1, 'condition' ) 
    ) if ( $type eq 'forecast');
    return sprintf( "Temp %d°C %s %s %s ", $gw->current( 'temp_c', 'humidity', 'wind_condition', 'condition' ) ) if ( $type eq 'weather');

}

sub help {
    return "weather [for] <city> or forecast [for] <city>";
}

1;

=head1 NAME

Bot::BasicBot::Pluggable::Module::GoogleWeather - get the weather forcast from NOAA

=head1 SYNOPSIS

Contacts C<weather.noaa.gov> and gets the weather report for a given
station.

=head1 IRC USAGE

    weather [for] <station>


=head1 AUTHOR

Simon Wistow, <simon@thegestalt.org>

based on code by Kevin Lenzo <lenzo@cs.cmu.edu>

=head1 COPYRIGHT

Copyright 2005, Simon Wistow

Distributed under the same terms as Perl itself.

=head1 SEE ALSO


=cut 


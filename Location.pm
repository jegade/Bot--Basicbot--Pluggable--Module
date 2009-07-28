package Bot::BasicBot::Pluggable::Module::Location;

use strict;
use utf8;
use Bot::BasicBot::Pluggable::Module;
use base qw(Bot::BasicBot::Pluggable::Module);

# Yahoo APP-ID
my $app_id = "CErOjBTV34E2hJqVJHiZQ8lw5AK85WmdAOGTqLj.qpM0ZcsufkfuaQkx_tNQGBU-";

use Geo::Coder::Yahoo;
use List::Util 'sum';

sub said {

    my ( $self, $mess, $pri ) = @_;

    my $body = $mess->{body};
    my $who  = $mess->{who};

    my $location = $1;

    if ( $body =~ /mylocation\s*(.*)/gi ) {

        my $geocoder = Geo::Coder::Yahoo->new( appid => $app_id );
        my $data = $geocoder->geocode( location => $1 );

        return "Nothing found for $1 " if @$data == 0;
        return "Please specifiy the location" if @$data > 1;

        push @{ $self->{location_data}{lati} }, $data->[0]->{latitude};
        push @{ $self->{location_data}{long} }, $data->[0]->{longitude};

        return "Add ".$data->[0]->{city}." to the list";

    } elsif ( $body =~ /^resultlocation/ ) {

        my @latitude  = @{ $self->{location_data}{lati} };
        my @longitude = @{ $self->{location_data}{long} };

        my $avg_longitude = average(@longitude);
        my $avg_latitude  = average(@latitude);

        return 'There http://maps.google.de/maps?hl=de&ie=UTF8&q=' . $avg_latitude . "," . $avg_longitude . "&z=9";

    } elsif ( $body =~ /^resetlocations/ ) {

        $self->{location_data} = {};

        return "Resetting location ... done";
        
    } else {

        return;
    }

}

sub average {
    my @items = @_;
    return sum(@items) / scalar(@items);
}

sub help {
    return "mylocation <city>, resultlocation or resetlocations";
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


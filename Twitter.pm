package Bot::BasicBot::Pluggable::Module::Twitter;

use strict;
use utf8;
use Bot::BasicBot::Pluggable::Module;
use base qw(Bot::BasicBot::Pluggable::Module);

use Twitter::Badge;

sub said {

    my ( $self, $mess, $pri ) = @_;

    my $body = $mess->{body};
    my $who  = $mess->{who};

    return unless $body =~ /^\s*twitter\s+(.*?)\s*\?*\s*$/;
    my $id = ( $1 eq 'me' ) ? $who : $1;
    my $twitter = Twitter::Badge->new( id => $id );    # create the object for that ID
    $twitter->fetch();                                                                                          # get information for this ID
    return $twitter->name . ' says - ' . $twitter->text . " (" . $twitter->followers_count . " Follower)\n";    # display status

}

sub help {
    return "twitter <username>";
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

